#!/bin/bash

    LIB_NAME=$1

    # Make sure a library name was passed
    if [ -z "${LIB_NAME}" ]; then
        echo "Please provide a library name"
        return
    fi

    echo "Creating $LIB_NAME"

    # Create the directory if it doesn't exist
    if [ ! -d "$LIB_NAME" ]; then
        echo " ==> Creating ${LIB_NAME} directory"
        mkdir $LIB_NAME
    fi

    # CD to the directory
    cd $LIB_NAME


    # Create the spark.json if it doesn't exist.
    if [ ! -f "spark.json" ]; then
        echo " ==> Creating spark.json file"
        cat <<EOS > spark.json
{
    "name": "${LIB_NAME}",
    "version": "0.0.1",
    "author": "Someone <email@somesite.com>",
    "license": "Choose a license",
    "description": "Briefly describe this library"
}
EOS
    fi


    # Create the README file if it doesn't exist
    if test -z "$(find ./ -maxdepth 1 -iname 'README*' -print -quit)"; then
        echo " ==> Creating README.md"
        cat <<EOS > README.md
TODO: Describe your library and how to run the examples
EOS
    fi


    # Create an empty license file if none exists
    if test -z "$(find ./ -maxdepth 1 -iname 'LICENSE*' -print -quit)"; then
        echo " ==> Creating LICENSE"
        touch LICENSE
    fi


    # Create the firmware/examples directory if it doesn't exist
    if [ ! -d "firmware/examples" ]; then
        echo " ==> Creating firmware and firmware/examples directories"
        mkdir -p firmware/examples
    fi


    # Create the firmware .h file if it doesn't exist
    if [ ! -f "firmware/${LIB_NAME}.h" ]; then
        echo " ==> Creating firmware/${LIB_NAME}.h"
        touch firmware/${LIB_NAME}.h
    fi


    # Create the firmware .cpp file if it doesn't exist
    if [ ! -f "firmware/${LIB_NAME}.cpp" ]; then
        echo " ==> Creating firmware/${LIB_NAME}.cpp"
        cat <<EOS > firmware/${LIB_NAME}.cpp
#include "${LIB_NAME}.h"

EOS
    fi


    # Create an empty example file if none exists
    if test -z "$(find ./firmware/examples -maxdepth 1 -iname '*' -print -quit)"; then
        echo " ==> Creating firmware/examples/example.cpp"
        cat <<EOS > firmware/examples/example.cpp
#include "${LIB_NAME}/${LIB_NAME}.h"

// TODO write code that illustrates the best parts of what your library can do

void setup {

}


void loop {

}
EOS
    fi


    # Initialize the git repo if it's not already one
    if [ ! -d ".git" ]; then
        GIT=`git init`
        echo " ==> ${GIT}"
    fi

    echo "Creation of ${LIB_NAME} complete!"
    echo "Check out https://github.com/spark/uber-library-example for more details"
