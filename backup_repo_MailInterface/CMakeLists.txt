cmake_minimum_required(VERSION 3.10)

project(EvolosDesktopApplication)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTKMM REQUIRED gtkmm-4.0)

include_directories(
    ./include
    ${GTKMM_INCLUDE_DIRS}
)

set(SOURCES
	src/main.cpp
    src/helloworld.cpp
)

add_executable(${PROJECT_NAME} ${SOURCES})


target_link_libraries(${PROJECT_NAME} ${GTKMM_LIBRARIES})