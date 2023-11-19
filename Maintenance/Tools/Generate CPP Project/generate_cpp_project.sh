#!/bin/bash

# Default values
current_date=$(date +"%Y%m%d_%H%M%S")
project_name="DefaultProject"
project_std="14"

while getopts ":n:s:" opt; do
    case $opt in
        n)
            project_name="$OPTARG"
            ;;
        s)
            cpp_standard="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

# Create project directory
project_dir="$project_name"_"$current_date" 
mkdir $project_dir
cd $project_dir

# Create main.cpp file
echo -e "#include <iostream>\n\nint main() {\n    std::cout << \"Hello, $project_name!\" << std::endl;\n    return 0;\n}" > main.cpp

# Create CMakeLists.txt file
echo -e "cmake_minimum_required(VERSION 3.10)\nproject($project_name)\n\nset(CMAKE_CXX_STANDARD $project_std)\n\nadd_executable($project_name main.cpp)" > CMakeLists.txt

# Display success message
echo "C++ project '$project_name' created successfully in '$project_dir' directory."
echo "Using Cmake Project Standard: '$project_std'"

