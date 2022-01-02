#!/bin/bash
set -e		# exit on error

# Available generators:
# clean             Remove all binaries and generated files
# codelite          Generate CodeLite project files
# gmake             Generate GNU makefiles for POSIX, MinGW, and Cygwin
# gmake2            Generate GNU makefiles for POSIX, MinGW, and Cygwin
# vs2005            Generate Visual Studio 2005 project files
# vs2008            Generate Visual Studio 2008 project files
# vs2010            Generate Visual Studio 2010 project files
# vs2012            Generate Visual Studio 2012 project files
# vs2013            Generate Visual Studio 2013 project files
# vs2015            Generate Visual Studio 2015 project files
# vs2017            Generate Visual Studio 2017 project files
# vs2019            Generate Visual Studio 2019 project files
# xcode4            Generate Apple Xcode 4 project files

# Replace the generator here
_generator=gmake

# ===================================================================
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [ -d "$SCRIPT_DIR/build/name" ]; then
    cd "$SCRIPT_DIR/build/name" && files=(*)
    if [[ "${files[0]}" == "*" ]]; then
        _projectname=
    else
        _projectname=${files[0]}
    fi
else
    _projectname=
fi

if test -z "$_projectname" 
then
    read -p "Enter the project name: " _projectname
fi

if [[ $_projectname = *" "* ]]; then
    echo -e "\e[91mThe project name must not contain spaces!\e[0m"
    exit
fi

echo Generating project $_projectname

"$SCRIPT_DIR/premake5/linux/premake5" $_generator --file="$SCRIPT_DIR/premake5.lua" --projectname=$_projectname

echo -e "\e[32mGeneration successful, next steps:\e[0m"
echo " - to build: 'cd build' and 'make'"
echo " - to execute: 'cd bin/YOUR_CONFIG' and './PROJECT_NAME'"

mkdir -p $SCRIPT_DIR/build/name/
touch $SCRIPT_DIR/build/name/$_projectname
