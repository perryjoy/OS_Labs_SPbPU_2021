#!/bin/bash
if [[ $# -ne 1 || $1 == "-h" || $1 == "-help" || $1 == "--help" ]]
then
  echo "---------------------------------------------------------------------------------------------"
  echo "This script runs daemon which source code src directory should exist at the same folder. Pass the name of cfg file to the script"
  echo "Daemons copies all files from directory FROM to directory TO, and splits them between subfolders 'OLD' and 'NEW'"
  echo "---------------------------------------------------------------------------------------------"
  echo "Cfg file should be at the same folder as the source code and to have format such as"
  echo "<parameter>=<value>"
  echo "---------------------------------------------------------------------------------------------"
  echo "list of parameters : FROM, TO, DT, OLD"
  echo "parameter FROM sets absolute path to source folder"
  echo "parameter TO sets absolute path to destination folder"
  echo "parameter DT sets time in seconds between copying procedures"
  echo "parameter OLD sets up the time in seconds, after that time since last editing file counts as old, otherwise counts as new"
  echo "---------------------------------------------------------------------------------------------"
  echo "value should be valid path for FROM and TO, and positive integer for DT and OLD"
  echo "---------------------------------------------------------------------------------------------"
else
  [ ! -d "/var/run/daemontest" ] && sudo mkdir /var/run/daemontest
  sudo chmod 777 /var/run/daemontest
  cmake -S src -B build
  cmake --build build --target all --config Release
  SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
  #echo "$1"
  echo ""$SCRIPTPATH"/build/lab1_2 $1"
  cd ./build
  rm -r ./CMakeFiles
  ls | grep -v lab1_2 | xargs rm
  cd ./..  
  "$SCRIPTPATH"/build/lab1_2 "$SCRIPTPATH"/src/"$1"
fi
