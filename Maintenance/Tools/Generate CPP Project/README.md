# generate_cpp_project.sh

This Bash script automates the creation of a basic C++ project with a customizable project name and C++ standard using CMake. It creates a project directory with a timestamp and populates it with a simple main.cpp file and a corresponding CMakeLists.txt file. This is a basic template, and you might need to modify it based on your project's specific requirements. For more advanced features and customization options, refer to the [CMake documentation](https://cmake.org/documentation/).

## Usage
```
./create_cpp_project.sh [-n <project_name>] [-s <cpp_standard>]
```
Options:
- -n <project_name>: Specify the name of the project. (Default: DefaultProject)
- -s <cpp_standard>: Specify the C++ standard for the project. (Default: 14)

## Example
```
./create_cpp_project.sh -n Helloworld -s 17
```
- Project name: Helloworld
- C++ Standard: 17

## Project Structure

```
<Project_Name>_<Timestamp>/
|-- main.cpp
|-- CMakeLists.txt
```

## Advance Cmake Settings
Lists your source files.
```
# Add your source files
set(SOURCES
    src/main.cpp
    src/foo.cpp
    src/bar.cpp
)
```

Specifies include directories for the target.
```
# Add include directories if needed
target_include_directories(MyExecutable
    PRIVATE
    include  # Add your include directory
)
```

Specifies libraries to link with the target.
```
# Add libraries if needed
target_link_libraries(MyExecutable
    PRIVATE
    my_library
)
```
