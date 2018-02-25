#!/bin/bash
#
# Author: Shelley Pham
# This bash script will create a new catkin package, build a workspace, create
# a src folder for the specified python scripts, and run roscore. If turtlesim
# is taken as an argument, it will run turtlesim.
#
# eg:
# ./rospy_magic.sh [option] "<filename.1> <filename.2>...<filename.n>"
#
# Options:
#	-t: turtlesim
#	-d: directory
#	-f: files
#	-h: help
#
# ./rospy_magic.sh -f "pyfile1.py pyfile2.py"
#
# Note:
# Make sure to run this script in the same directory as your python file

turtle=false
directoryN=''
files=''

while getopts 'tf:d:' flag; do
case ${flag} in
	t) turtle=true ;;
	d) directory="${OPTARG}" ;;
	f) files="${OPTARG}" ;;
	*) error "Unexpected option ${flag}" exit 0;;
esac
done

if $turtle = true; then
	echo "=== Activated TurtleSim! ==="
fi

if [ "$directory" != '' ]; then
	echo $directory
fi

if [ "$files" != '' ]; then
for file in $files; do
	echo $file
done
fi
