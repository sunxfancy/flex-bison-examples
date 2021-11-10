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

目前拥有的示例：

* simple-c   最简单的C代码版Flex/Bison示例，使用union和全局函数，初学推荐
* simple-cpp 如果你想在C代码基础上使用一点C++，那么推荐你从该示例入手
* reentrant-c 可重入版的C代码版，适合普通C工程使用，避免全局变量的使用，便于多线程安全调用
* reentrant-variant-cpp C++工程版示例，避免全局变量的使用，并且使用variant替代union，可以在parser中方便地使用各种带构造函数的类型
* optional-semicolon 目前效果最好的可选分号实现，目前是基于基础C代码版，只做思路上的实现，实际应用时请根据需要修改裁剪，同时这个语言设计也是取自我之前写的脚本语言slip，可以用作语言设计的参考
* elite2 一个较完整的语法示例，但没有具体的语义分析部分，设计取自我之前写的elite编程语言第二版
* utf-8  使用flex支持utf-8和中文词语法的示例，代码中原生支持中文，或者做游戏引擎时制作脚本引擎，中文支持还是非常有用的
* error-recovery 异常恢复的基本操作，使用error关键词来匹配到下一个合法的token，这里展示了其基本用法。
* error-handling 来自IBM的示例代码，展示如果打印漂亮的错误提示信息，打印错误代码行等等。


在这个项目的wiki中我将介绍一下复杂的问题是如何被解决的，以及背后的一些实现思路，Flex、Bison使用的经验等。

[Bison中句尾可选分号的实现](https://github.com/sunxfancy/flex-bison-examples/wiki/Bison%E5%AE%9E%E7%8E%B0%E5%8F%A5%E5%B0%BE%E7%9A%84%E5%8F%AF%E9%80%89%E5%88%86%E5%8F%B7-Optional-semicolon-grammar-in-Bison)
