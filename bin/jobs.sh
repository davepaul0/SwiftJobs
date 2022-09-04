#!/bin/bash

echo "**** SwiftJobs ****"

# save the directory so we can return the user there:
startdir=$(pwd)

locate_and_run() {
  folder=${PWD##*/}
  if [ "$folder" == "MyJobs" ]; then
    run $@
  fi

  if [ -d "MyJobs" ]; then
    cd MyJobs
    run $@
  fi

  if [ $(pwd) == "/" ]; then
    echo "We couldn't find your MyJobs folder!  Exiting."
    cd $startdir
    exit 1
  fi

  cd ../
  locate_and_run $@
}

run() {
  echo "Found a project at ${PWD}"

  if [ "$1" == "list" ] || [ "$1" == "run" ]; then
    swift run MyJobs $@
    status=$?
    cd $startdir
    exit $status
  fi

  echo "Use one of the following commands:"
  echo "swiftjobs init"
  echo "swiftjobs list"
  echo "swiftjobs run <job name> [arguments]"
  cd $startdir
  exit 1
}

initialize() {
  echo "Creating a new project at $(pwd)/MyJobs"
  brew_dir=$(brew --prefix SwiftJobs)
  cp -r ${brew_dir}/libexec/starter MyJobs 
  echo "MyJobs folder is created!  Add jobs to the JobsProvider and then use 'swiftjobs run <job name>'."
}

if [ "$1" == "init" ]; then
  initialize $0
  exit 0
fi

locate_and_run $@
