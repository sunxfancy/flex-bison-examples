# Flex/Bison Examples

Here is a list of flex/bison examples to show some advanced features in the newest versions of flex/bison. 
There are several topics in this list:
1. Reentrancy - this is important for parsing in multithread programs 
2. C++  - many old flex/bison tutorials only show how to use the C API, but bison do provide a nice and clean C++ api now. Using the variant and token constructor now!
3. Optional semicolon - this is still an open question from the first year I learn bison (5years ago), but I wish to try some ideas in this repo
4. UTF-8 support - flex is hard to implement utf-8 but I do need Chinese!
5. Error recovery - the most difficult thing in bison 
6. Better error message - IBM has an old but nice article to show how to achieve it: https://developer.ibm.com/tutorials/l-flexbison/


Makefile and CMakeLists are provided to build the project. Please install the newest flex/bison in your system.



在这个项目的wiki中我将介绍一下这些问题是如何被解决的，以及背后的一些实现思路。

[Bison中句尾可选分号的实现](https://github.com/sunxfancy/flex-bison-examples/wiki/Bison%E5%AE%9E%E7%8E%B0%E5%8F%A5%E5%B0%BE%E7%9A%84%E5%8F%AF%E9%80%89%E5%88%86%E5%8F%B7-Optional-semicolon-grammar-in-Bison)
