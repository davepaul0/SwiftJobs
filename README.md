# SwiftJobs

> **Warning**
> SwiftJobs is not ready for general adoption.

A general use task runner in Swift. Inspired by Rake, Fastlane, and others.

Define your "jobs" in Swift:
```swift
@main
struct MyJobs: JobsProvider {
    static var jobs: Jobs {
        Job("hello", description: "Says hello!") { args in
            Output.print("hello!")
        }
        
        Job("script", description: "Runs a shell script") { args in
            try Command.run("scripts/build.sh")
            Output.success("script completed!")
        }
    }
}
```

Then run them from the command line:
```shell
swiftjobs run hello
```


## Installation

Install SwiftJobs with Homebrew:

```shell
brew install davepaul0/tap/swiftjobs
```

## Setup

```shell
swiftjobs init
```

SwiftJobs will create a "MyJobs" Swift package at your current location.
Open the package in Xcode and add your jobs!

## List

List all jobs declared in the local `MyJobs` project:
```shell
swiftjobs list
```

## Run

```shell
swiftjobs run <job name>
```

### On working directories and folder hierarchies

* `swiftjobs` can be run from any descendant folder from a `MyJobs` project root, OR any descendant of a folder that HAS a `MyJobs` project.
* `swiftjobs` will always execute its `Job` instances with the current working directory set to the parent of the `MyJobs` parent root. 

Example:
```
~/
 |- MyCodeProject/
    |- MyJobs/
    |   |- Package.swift
    |   |- ...
    |- src/
    |  |- tests/
    |  |- ...
    |- resources/
    |- ...
```
Given the above project configuration, `swiftjobs` can be executed inside of MyJobs, OR inside MyCodeProject or any of its descendants (src, tests, resources, etc).
The current working directory in a `Job` will always be `~/MyCodeProject/`.
