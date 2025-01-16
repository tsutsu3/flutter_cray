cmake_minimum_required(VERSION 3.16)

set(PROJECT_NAME "flutter_cray")
project(${PROJECT_NAME} LANGUAGES C)


# Fix GetGitRevisionDescription module path
set(CRAY_CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../third_party/c-ray/cmake")

if (EXISTS "${CRAY_CMAKE_MODULE_PATH}/GetGitRevisionDescription.cmake")
    list(APPEND CMAKE_MODULE_PATH "${CRAY_CMAKE_MODULE_PATH}")
    include(GetGitRevisionDescription)
    message(STATUS "GetGitRevisionDescription module loaded successfully.")
else()
    message(WARNING "GetGitRevisionDescription module not found. Skipping.")
endif()

# Invoke the build for native code shared with the other target platforms.
# This can be changed to accommodate different builds.
add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/.." "${CMAKE_CURRENT_BINARY_DIR}/shared")

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
set(flutter_cray_bundled_libraries
  $<TARGET_FILE:c-ray-shared>
  PARENT_SCOPE
)