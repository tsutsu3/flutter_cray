cmake_minimum_required(VERSION 3.16)
project(c-ray C)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

message(STATUS "The C compiler is: ${CMAKE_C_COMPILER}")

option(BUILD_EXECUTABLE "Build the executable c-ray" OFF)

if(NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Release)
endif()

if (DEFINED CMAKE_ANDROID_NDK)
    set(ANDROID TRUE)
endif()

# Set compile flags
if (MSVC AND NOT ANDROID)
    # message(FATAL_ERROR "<!> Windows is not supported yet. Aborting build.")
    add_definitions(-DWINDOWS)
    add_definitions(/D_CRT_SECURE_NO_WARNINGS /D_CRT_NONSTDC_NO_DEPRECATE /D_SCL_SECURE_NO_WARNINGS)
	# Avoid non-compliant standard library extensions
	add_definitions(/D_CRT_DECLARE_NONSTDC_NAMES)
	# Avoid windows.h junk
	add_definitions(/DNOMINMAX)
	# Avoid windows.h from including some usually unused libs like winsocks.h, since this might cause some redefinition errors.
	add_definitions(/DWIN32_LEAN_AND_MEAN)

    set(CMAKE_C_FLAGS "/W3 /MP /Zi /Zo /permissive-")
    set(CMAKE_C_FLAGS_RELEASE "/O2 /GS- /MD")
    set(CMAKE_C_FLAGS_DEBUG "/Od /MDd /Zi")
elseif (ANDROID)
    message(STATUS "Building for Android")
    add_definitions(-DANDROID)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700")
    set(CMAKE_C_FLAGS_RELEASE "-O2")
    set(CMAKE_C_FLAGS_DEBUG "-O0 -g")
elseif (UNIX AND NOT ANDROID)
    set(CMAKE_C_FLAGS "-Wall -Wextra -Wno-missing-field-initializers -std=c99 -D_POSIX_C_SOURCE -D_XOPEN_SOURCE=600 -g -ftree-vectorize -flto=auto")
    set(CMAKE_C_FLAGS_RELEASE "-O2")
    set(CMAKE_C_FLAGS_DEBUG "-O0 -g")
else ()
    message(FATAL_ERROR "<!> Unsupported platform. Aborting build.")
endif()

# Include GetGitRevisionDescription for git hash
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/third_party/c-ray/cmake")
include(GetGitRevisionDescription)
get_git_head_revision(GIT_REFSPEC GIT_SHA1)

# Generate gitsha1.c
configure_file(
    third_party/c-ray/src/common/gitsha1.c.in
    ${CMAKE_BINARY_DIR}/generated/gitsha1.c
    @ONLY
)

# Find source files
file(GLOB_RECURSE CRAY_SOURCES_LIB third_party/c-ray/src/lib/*.c third_party/c-ray/src/common/*.c)
file(GLOB_RECURSE CRAY_SOURCES_DRIVER third_party/c-ray/src/driver/*.c)

# Include directories
include_directories(third_party/c-ray/include)

# Add generated gitsha1.c to sources
list(APPEND CRAY_SOURCES_LIB ${CMAKE_BINARY_DIR}/generated/gitsha1.c)

if (BUILD_EXECUTABLE)
    # Create Static Library (libc-ray.a / libc-ray.lib)
    add_library(c-ray-static STATIC ${CRAY_SOURCES_LIB})
    set_target_properties(c-ray-static PROPERTIES OUTPUT_NAME "libc-ray")

    if (MSVC AND NOT ANDROID)
        target_compile_options(c-ray-static PRIVATE /W3)
    elseif (ANDROID)
        target_compile_options(c-ray-static PRIVATE -fPIC)
    elseif (UNIX AND NOT ANDROID)
        target_compile_options(c-ray-static PRIVATE -fPIC -fvisibility=default)
    endif()

    if (MSVC AND NOT ANDROID)
        target_link_libraries(c-ray-static PRIVATE ws2_32 advapi32)
    elseif (ANDROID)
        target_link_libraries(c-ray-static PRIVATE log)
    elseif (UNIX AND NOT ANDROID)
        target_link_libraries(c-ray-static PRIVATE -lpthread -lm -ldl)
    endif ()

    # Create Executable (bin/c-ray) linked statically with libc-ray.a
    if (NOT ANDROID)
        add_executable(c-ray ${CRAY_SOURCES_DRIVER})
        set_target_properties(c-ray PROPERTIES OUTPUT_NAME "c-ray")
        target_link_libraries(c-ray PRIVATE c-ray-static)
    endif()
endif()

# Create Shared Library (libc-ray.so / libc-ray.dll)
add_library(c-ray-shared SHARED ${CRAY_SOURCES_LIB})
set_target_properties(c-ray-shared PROPERTIES OUTPUT_NAME "c-ray")

if (MSVC AND NOT ANDROID)
    target_compile_options(c-ray-shared PRIVATE /W3)
elseif (ANDROID)
    target_compile_options(c-ray-shared PRIVATE -fPIC)
elseif (UNIX AND NOT ANDROID)
    target_compile_options(c-ray-shared PRIVATE -fPIC -fvisibility=hidden)
endif()

target_compile_definitions(c-ray-shared PRIVATE CR_BUILDING_LIB)

# IPO (Interprocedural Optimization)
include(CheckIPOSupported)
if (CMAKE_BUILD_TYPE STREQUAL "Release")
    check_ipo_supported(RESULT ipo_supported OUTPUT ipo_errors)
    if (ipo_supported)
        message(STATUS "Enabling IPO")
        if (BUILD_EXECUTABLE)
            set_property(TARGET c-ray-static PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
        endif()
        set_property(TARGET c-ray-shared PROPERTY INTERPROCEDURAL_OPTIMIZATION TRUE)
    else()
        message(WARNING "IPO is not supported by this compiler. Everything will work, just a bit slower for now!")
    endif()
endif()

if (NO_IPO)
    message(STATUS "Explicitly disabling IPO")
    if (BUILD_EXECUTABLE)
        set_property(TARGET c-ray-static PROPERTY INTERPROCEDURAL_OPTIMIZATION FALSE)
    endif()
    set_property(TARGET c-ray-shared PROPERTY INTERPROCEDURAL_OPTIMIZATION FALSE)
    unset(NO_IPO CACHE)
endif()

if (NO_LOGO)
    message(STATUS "Disabling logo")
    target_compile_definitions(c-ray PRIVATE -DNO_LOGO)
endif()

if (TESTING)
    message(STATUS "Enabling test suite.")
    target_compile_definitions(c-ray PRIVATE -DCRAY_TESTING)
endif()
