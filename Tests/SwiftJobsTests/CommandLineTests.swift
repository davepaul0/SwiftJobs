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
/// A modified version of the MyJobs starter template is copied into "<projectRoot>/test" along with the command line executable.
/// Each test function uses SwiftJobs' `Command` to run the executable.
final class CommandLineTests: XCTestCase {
    static override func setUp() {
        try? FileManager.default.removeItem(atPath: "\(projectRoot)/test")

        try! FileManager.default.copyItem(atPath: "\(projectRoot)/bin",
                                     toPath: "\(projectRoot)/test")
        try! FileManager.default.moveItem(atPath: "\(projectRoot)/test/starter", toPath: "\(projectRoot)/test/MyJobs")

        // Modify the MyJobs package manifest to use our local code
        let regex = #"\.package[(].+[)]"#
        let replacement = ".package(path: \"\(projectRoot)\")"
        let command = "sed -r -i '' 's|\(regex)|\(replacement)|g' \(projectRoot)/test/MyJobs/Package.swift"
        try! Command.run(command)
    }

    static override func tearDown() {
        try? FileManager.default.removeItem(atPath: "\(projectRoot)/test")
    }

    override func setUp() {
        super.setUp()
        FileManager.default.changeCurrentDirectoryPath(projectRoot + "/test")
    }

    // Running `swiftjobs` without any additional arguments should fail.
    func testNoArgs() throws {
        XCTAssertThrowsError(try Command.run("./jobs.sh"),
                             "Command should return an error since no arguments were provided") { error in

            // The error message should provide some guidance:
            XCTAssert("\(error)".localizedCaseInsensitiveContains("Use one of the following"))
        }
    }

    // Running `swiftjobs` with a single "list" argument will register as a success.
    func testJobsList() throws {
        let output = try Command.run("./jobs.sh list")
        XCTAssert(output.localizedCaseInsensitiveContains("Here are the available jobs"))
    }

    // Running `swiftjobs` with a "run" argument, but not specifying a job name, is an error.
    func testRunWithoutJobName() throws {
        XCTAssertThrowsError(try Command.run("./jobs.sh run"),
                             "Command should return an error since no job was provided") { error in
            XCTAssert("\(error)".localizedCaseInsensitiveContains("Please specify a job name"))
        }
    }
}
