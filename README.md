# Flex/Bison Examples

Here is a list of flex/bison examples to show some advanced features in the newest versions of flex/bison. 
There are serveral topics in this lists:
1. Reentrancy - this is important for parsing in multithread programs 
2. C++  - many old flex/bison tutorials only show how to use the C API, but bison do provide a nice and clean C++ api now. Using the variant and token constructor now!
3. Optional semicolon - this is still a open question from the first year I learn bison (5years ago), but I wish to try some ideas in this repo
4. UTF-8 support - flex is hard to implement utf-8 but I do need Chinese!
5. Error recovery - the most difficult things in bison 
6. Better error message - IBM has an old but nice article to show how to achieve it: https://developer.ibm.com/tutorials/l-flexbison/


Makefile and CMakeLists are provided to build the project. Please install the newest flex/bison in your system.

