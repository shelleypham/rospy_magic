#!/bin/bash
#
# Author: Shelley Pham
# This bash script will create a new catkin package, build a workspace, create
# a src folder for the specified python scripts, and run roscore. If turtlesim
# is taken as an argument, it will run turtlesim.
#
# eg:
# ./rospy_magic.sh [options] "<filename.1> <filename.2>...<filename.n>"
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
#
# TODO: IMPLEMENT PROJECT NAME OPTION

turtle=false
directory=''
files=''

while getopts 'tf:d:' flag; do
case ${flag} in
	t) turtle=true ;;
	d) directory="${OPTARG}" ;;
	f) files="${OPTARG}" ;;
	*) error "Unexpected option ${flag}" exit 0;;
esac
done

echo "Creating your workspace environment..."
# Check whether directory has python files. If not, return error message.
# Else, use files for workplace environment.
if [ "$directory" != '' ]; then
	pyfile_exists=false
	for file in `ls $directory`; do
		if [[ "$file" = *".py" ]]; then
			echo $file
			pyfile_exists=true
		fi
	done
	if [ "$pyfile_exists" = false ]; then
		echo "There are no py files in your directory $directory. Please place the necessary files there and try again."
		exit 1
	fi
fi

# Check whether the py files exists. If not, return error message
# Else, use files for workplace environment.
if [ "$files" != '' ]; then
	pyfile_exists=true
	for file in $files; do
		if [ ! -f $file ]; then
			echo "File $file not found."
			pyfile_exists=false
		fi
	done
	if [ "$pyfile_exists" = false ]; then
		echo "The py files you listed in your current directory `pwd` does not exist. Please check your spelling or place the necessary files there adn try again."
		exit 1
	fi
fi

echo "RIGHT HERE"
files=''
for file in `ls $directory`; do
	echo $file
	files+=" $file"
done
echo $files
echo "Trying stuff"
for file in $files; do
	echo $file
done

# Make src folder and change file permissions
mkdir -p rosproject/src/project
if [ "$directory" != '']; then
	for file in `ls $directory`; do
		files+=" $file"
	done
	
	mv $directory/* .
fi

for file in $files; do
	chmod +x $file
done

mkdir -p rosproject/src/project

mv $files rosproject/src/project
cd rosproject/src


echo "Initializing catkin..."
catkin_init_workspace

echo "Creating catkin package..."
catkin_create_pkg project std_msgs rospy roscpp

cd ..

echo "Making catkin executable..."
catkin_make

echo "Running roscore in Terminal 0..."
x-terminal-emulator -e bash -c "roscore" &

if $turtle = true; then
	echo "Running TurtleSim in Terminal 1..."
	x-terminal-emulator -e bash -c "rosrun turtlesim turtlesim_node; $SHELL" &
fi

for file in $files; do	
	echo "Running $file..."
x-terminal-emulator -e bash -c "source devel/setup.bash; rosrun project $file; $SHELL" &
done

exit 0
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


