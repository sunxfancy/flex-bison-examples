"""Black-box regression tests; run with a path to the calculator executable."""

import pathlib
import subprocess
import sys
import unittest


BINARY = pathlib.Path(sys.argv.pop(1)).resolve() if len(sys.argv) > 1 else (
    pathlib.Path(__file__).resolve().parent / "build" / "modern-cpp"
)


class CalculatorTest(unittest.TestCase):
    def run_calculator(self, source):
        return subprocess.run(
            [str(BINARY)], input=source, text=True, capture_output=True, timeout=5
        )

    def test_valid_expressions(self):
        cases = [
            ("", ""),
            ("\n \t\n", ""),
            ("1 + 2 * 3\n", "7\n"),
            ("-(4 + 2) / 2\n", "-3\n"),
            ("8 / 2 / 2\n10 - 3 - 2\n", "2\n5\n"),
            (".5 + 1.25\n2. * 3\n", "1.75\n6\n"),
            ("\r\n1 + 2\r\n4\r", "3\n4\n"),
        ]
        for source, expected in cases:
            with self.subTest(source=source):
                result = self.run_calculator(source)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stdout, expected)
                self.assertEqual(result.stderr, "")

    def test_errors(self):
        cases = [
            ("1 + )\n", "1.5: syntax error, unexpected )"),
            ("1 / 0\n", "1.5: division by zero"),
            ("\n  @\n", "2.3: invalid character: @"),
            ("1 + 2", "unexpected end of file"),
            ("(1 + 2\n", "syntax error"),
        ]
        for source, diagnostic in cases:
            with self.subTest(source=source):
                result = self.run_calculator(source)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(result.stdout, "")
                self.assertIn(diagnostic, result.stderr)


if __name__ == "__main__":
    unittest.main()
