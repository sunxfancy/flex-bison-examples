cmake_minimum_required(VERSION 3.16)
project(modern-cpp LANGUAGES CXX)
find_package(BISON 3.8 REQUIRED)
find_package(FLEX 2.6.4 REQUIRED)
BISON_TARGET(ModernParser parser.y ${CMAKE_CURRENT_BINARY_DIR}/parser.cpp
             DEFINES_FILE ${CMAKE_CURRENT_BINARY_DIR}/parser.hpp
             COMPILE_FLAGS "-Wall -Werror")
FLEX_TARGET(ModernLexer lexer.l ${CMAKE_CURRENT_BINARY_DIR}/lexer.cpp)
ADD_FLEX_BISON_DEPENDENCY(ModernLexer ModernParser)
add_executable(modern-cpp main.cpp ${BISON_ModernParser_OUTPUTS} ${FLEX_ModernLexer_OUTPUTS})
target_compile_features(modern-cpp PRIVATE cxx_std_17)
target_include_directories(modern-cpp PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
