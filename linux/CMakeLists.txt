cmake_minimum_required(VERSION 3.16)

set(PROJECT_NAME "flutter_cray")
project(${PROJECT_NAME} LANGUAGES C)

# Path to the pre-built library
# set(LIBC_RAY_SO_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../../build/linux/lib/libc-ray.so")
get_filename_component(LIBC_RAY_SO_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../../build/linux/lib/libc-ray.so" ABSOLUTE)

# Ensure the pre-built .so exists
if (NOT EXISTS "${LIBC_RAY_SO_PATH}")
    message(FATAL_ERROR "Pre-built libc-ray.so not found at ${LIBC_RAY_SO_PATH}. Run 'cmake .. && make' in build/linux first.")
endif()

# Define the target directory for the shared library
set(BUNDLE_LIB_DIR "${CMAKE_BINARY_DIR}/bundle/lib")

# Create the directory if it does not exist
file(MAKE_DIRECTORY "${BUNDLE_LIB_DIR}")

# Only copy if the file does not already exist (prevents overwrite)
if (NOT EXISTS "${BUNDLE_LIB_DIR}/libc-ray.so")
    file(COPY "${LIBC_RAY_SO_PATH}" DESTINATION "${BUNDLE_LIB_DIR}")
endif()

# Set Flutter plugin to use the copied .so
set(ffigen_app_bundled_libraries
  "${BUNDLE_LIB_DIR}/libc-ray.so"
  PARENT_SCOPE
)