//
//  CommandLineTests.swift
//  
//
//  Created by Dave Paul on 9/4/22.
//

import SwiftJobs
import XCTest

private let projectRoot: String = {
    let filePath = #filePath
    let range = filePath.range(of: "/Tests/")
    return String(filePath.prefix(upTo: range!.lowerBound))
}()

/// CommandLineTests executes actual command line invocations of `swiftjobs` and tests the results.
/// `swiftjobs` is run against the MyJobs starter template in `bin/`.
/// Each test function uses SwiftJobs' `Command` to run the executable.
final class CommandLineTests: XCTestCase {
    static override func setUp() {
        FileManager.default.changeCurrentDirectoryPath(projectRoot + "/bin/MyJobs")
        try! Command.run("swift package edit --path ../.. SwiftJobs")
    }

    static override func tearDown() {
        FileManager.default.changeCurrentDirectoryPath(projectRoot + "/bin/MyJobs")
        try! Command.run("swift package unedit SwiftJobs")
    }

    override func setUp() {
        super.setUp()
        FileManager.default.changeCurrentDirectoryPath(projectRoot + "/bin")
    }

    // Running `swiftjobs` without any additional arguments should fail.
    func testNoArgs() throws {
        XCTAssertThrowsError(try Command.run("./jobs.sh"),
                             "Command should return an error since no arguments were provided") { error in

            // The error message should provide some guidance:
            XCTAssert("\(error)".contains("Use one of the following"))
        }
    }

    // Running `swiftjobs` with a single "list" argument will register as a success.
    func testJobsList() throws {
        let output = try Command.run("./jobs.sh list")
        XCTAssert(output.contains("Here are the available jobs"))
    }

    // Running `swiftjobs` with a "run" argument, but not specifying a job name, is an error.
    func testRunWithoutJobName() throws {
        XCTAssertThrowsError(try Command.run("./jobs.sh run"),
                             "Command should return an error since no job was provided") { error in
            XCTAssert("\(error)".contains("Please specify a job name"))
        }
    }
}
