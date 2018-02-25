#!/bin/bash
#
# Author: Shelley Pham
# This bash script will create a new catkin package, build a workspace, create
# a src folder for the specified python scripts, and run roscore. If turtlesim
# is taken as an argument, it will run turtlesim.
#
# ./rospy_magic.sh [option] [arguments]
# ./rospy_magic.sh -tf pyfile1.py pyfile2.py...
#
# Note:
# Make sure to run this script in the same directory as your python file

while getopts 't' flag; do
case ${flag} in
	t) echo "Yay! It works!"
			exit 0;;
	*) error "Unexpected option ${flag}" ;;
esac
done
