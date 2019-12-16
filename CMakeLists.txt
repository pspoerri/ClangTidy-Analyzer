cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project(TestProject LANGUAGES CXX)

add_executable(${PROJECT_NAME})

set(CMAKE_CXX_FLAGS "-Wall -Werror -Weverything -Wextra")

if(NOT "$ENV{CLANG_TIDY_BIN}" STREQUAL "")
	set_target_properties(${PROJECT_NAME} PROPERTIES
        ASM_CLANG_TIDY "$ENV{CLANG_TIDY_BIN}"
        CXX_CLANG_TIDY "$ENV{CLANG_TIDY_BIN};-checks='modernize*'"
        C_CLANG_TIDY "$ENV{CLANG_TIDY_BIN}")
endif()

target_sources(${PROJECT_NAME} PRIVATE
	"${CMAKE_CURRENT_LIST_DIR}/main.cpp")
