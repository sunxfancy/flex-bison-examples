# Flex/Bison Examples


Here is a list of flex/bison examples to show some advanced features in the newest versions of flex/bison. 
There are several topics in this list:
1. Reentrancy - this is important for parsing in multithread programs 
2. C++  - many old flex/bison tutorials only show how to use the C API, but bison do provide a nice and clean C++ api now. Using the variant and token constructor now!
3. Optional semicolon - this is still an open question from the first year I learn bison (5years ago), but I wish to try some ideas in this repo
4. UTF-8 support - flex is hard to implement utf-8 but I do need Chinese!
5. Error recovery - the most difficult thing in bison 
6. Better error message - IBM has an old but nice article to show how to achieve it: https://developer.ibm.com/tutorials/l-flexbison/
7. Indentation - python-like grammar is always a hard topic in flex, we will show how to achieve it.

Makefile and CMakeLists are provided to build the project. Please install the newest flex/bison in your system. Each project can be compilated separately. 

Examples currently available: 
* `simple-c`      The simplest C code version Flex/Bison example, using union and global functions, recommended for beginners 
* `simple-cpp`    If you want to use a little C++ on the basis of C code, then I recommend you to use this example Start with 
* `reentrant-c`   reentrant version of the C code version, suitable for ordinary C projects, avoid the use of global variables, facilitate multi-threaded safe calls 
* `reentrant-variant-cpp`   C++ project version example, avoid the use of global variables, and use Variant replaces union, you can easily use various types with constructors in parser
* `optional-semicolon`   The best alternative semicolon implementation at present, it is based on the basic C code version, only the realization of ideas, practical applications Please modify it according to your needs. At the same time, this language design is also taken from the script language slip I wrote before, which can be used as a reference for language design. 
* `python-like-indentation`  To determine the effect of block and optional semicolon, and also show the usage of flex start condition
* `elite2`   A more complete syntax example, but no specific semantic analysis part, the design is based on the second edition of the elite programming language written by myself. 
* `utf-8`    Use flex to support utf-8 and Multilingual vocabulary 
* `error-recovery`   basic operation of abnormal recovery, use error Keywords to match to the next valid token, here is the basic usage. 
* `error-handling`   sample code from IBM, showing how to print beautiful error messages, print error code lines, and so on.

Optional semicolon example, it can add the semicolon only at the end of line which needs a semicolon (the second line will not be inserted a ';') :
```
defun work(name) {
    printf("hello world ~ %s\n",
        name)
    printf("optional semicolon example");
}

work("xiaofan")
```


Python-like indentation example, it can parse the following code (if you didn't finish the line, the indentation will not influence your code block):
```python
def work(name):
    for i in range(1, 30)
        print(i)
	
        a = a + b + c + 
             q + parse(1, 2)  // you can continue writing without considering indentation
        print(q)
```

Utf-8 example: 
```
类型 速度 = 12
类型 文本 = "flex中文支持"
```

Error recovery example， it can parse all lines and output the error messages for each line:
```
(59 + 33) / 2 = 
123 + (12 =
59 + 33 / 3 =
1231 - ( 23 +  / 4 =
91 * ) ( - 3 =
```

Other My Projects using flex/bison could be a reference:

* [FSMLanuage](https://github.com/sunxfancy/FSMLanguage)
* [UMake](https://github.com/sunxfancy/UMake)
* [RedApple](https://github.com/elite-lang/RedApple)
* [MiniC](https://github.com/sunxfancy/miniC)
* [LR_Scanner](https://github.com/elite-lang/LR_Scanner)

目前拥有的示例：

* `simple-c`   最简单的C代码版Flex/Bison示例，使用union和全局函数，初学推荐
* `simple-cpp` 如果你想在C代码基础上使用一点C++，那么推荐你从该示例入手
* `reentrant-c` 可重入版的C代码版，适合普通C工程使用，避免全局变量的使用，便于多线程安全调用
* `reentrant-variant-cpp` C++工程版示例，避免全局变量的使用，并且使用variant替代union，可以在parser中方便地使用各种带构造函数的类型
* `optional-semicolon` 目前效果最好的可选分号实现，目前是基于基础C代码版，只做思路上的实现，实际应用时请根据需要修改裁剪，同时这个语言设计也是取自我之前写的脚本语言slip，可以用作语言设计的参考
* `python-like-indentation` 一个类似python的语法，改自optional-semicolon，实现了缩进确定block和可选分号的效果，同时也展示了flex start condition的用法
* `elite2` 一个较完整的语法示例，但没有具体的语义分析部分，设计取自我之前写的elite编程语言第二版
* `utf-8`  使用flex支持utf-8和中文词语法的示例，代码中原生支持中文，或者做游戏引擎时制作脚本引擎，中文支持还是非常有用的
* `error-recovery` 异常恢复的基本操作，使用error关键词来匹配到下一个合法的token，这里展示了其基本用法。
* `error-handling` 来自IBM的示例代码，展示如果打印漂亮的错误提示信息，打印错误代码行等等。


在这个项目的wiki中我将介绍一下复杂的问题是如何被解决的，以及背后的一些实现思路，Flex、Bison使用的经验等。

[Bison中句尾可选分号的实现](https://github.com/sunxfancy/flex-bison-examples/wiki/Bison%E5%AE%9E%E7%8E%B0%E5%8F%A5%E5%B0%BE%E7%9A%84%E5%8F%AF%E9%80%89%E5%88%86%E5%8F%B7-Optional-semicolon-grammar-in-Bison)

[flex/bison实现Python风格缩进代码的解析](https://github.com/sunxfancy/flex-bison-examples/wiki/Flex-%E5%92%8C-Bison-%E9%85%8D%E5%90%88%E5%AE%9E%E7%8E%B0Python%E9%A3%8E%E6%A0%BC%E8%AF%AD%E6%B3%95%E8%A7%A3%E6%9E%90)
