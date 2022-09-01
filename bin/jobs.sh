#!/bin/bash

echo "**** SwiftJobs ****"

# save the directory so we can return the user there:
startdir=$(pwd)

locate_and_run() {
  folder=${PWD##*/}
  if [ $folder == "MyJobs" ]; then
    swift run MyJobs $@
    cd $startdir
    exit 0
  fi

  if [ -d "MyJobs" ]; then
    cd MyJobs
    swift run MyJobs $@
    cd $startdir
    exit 0
  fi

  if [ $(pwd) == "/" ]; then
    echo "We couldn't find your MyJobs folder!  Exiting."
    cd $startdir
    exit 1
  fi

  cd ../
  locate_and_run $@
}

initialize() {
  echo "Creating a new project at $(pwd)/MyJobs"
}

if [ $1 == "init" ]; then
  initialize $0
  exit 0
fi

locate_and_run $@
