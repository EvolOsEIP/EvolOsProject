cmake_minimum_required(VERSION 3.22)
project(buttons)

set(CMAKE_CXX_STANDARD 20)
file(GLOB_RECURSE WINDOW_SOURCES "MyWindow.cpp")
file(GLOB_RECURSE BUTTON_SOURCES "Button.cpp")
file(GLOB_RECURSE CTA_SOURCES "cta/*.cpp")

# add gtkmm
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTKMM gtkmm-3.0)
include_directories(include)
include_directories(${GTKMM_INCLUDE_DIRS})
link_directories(${GTKMM_LIBRARY_DIRS})

# add executable
add_executable(cta_buttons ${WINDOW_SOURCES} ${BUTTON_SOURCES} ${CTA_SOURCES})
target_link_libraries(cta_buttons ${GTKMM_LIBRARIES})
