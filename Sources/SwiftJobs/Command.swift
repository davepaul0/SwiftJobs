import Foundation
import os

/// A namespace for executing shell commands inside of a `Job`.
public enum Command {

    /// Runs the given shell command inside a subprocess, blocking the current thread until the command completes.
    ///
    /// If the exit status of the command is not "0", this function will throw a `SwiftJobs.Error` instance containing the command output.
    ///
    /// - Parameters:
    ///   - input: The shell command to run.
    ///   - path: An optional filepath for the subprocess. If `nil`, the command will inherit the current program path (See `FileManager.currentDirectoryPath`)
    /// - Returns: The output of the command.
    @discardableResult public static func run(_ input: String, path: URL? = nil) throws -> String {
        Output.info("Running the following command: \(input)")
        let task = Process()
        let pipe = Pipe()

        task.currentDirectoryURL = path
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", input]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil

        let builder = LineBuilder()
        Task {
            for try await line in pipe.fileHandleForReading.bytes.lines {
                Output.quote(line)
                builder.append(line)
            }
        }

        try task.run()
        task.waitUntilExit()
        let output = builder.result

        if task.terminationStatus != 0 {
            throw Error(output)
        }

        return output
    }

    /// Runs the given shell command in an async context.
    static public func async(_ input: String, path: URL? = nil) async throws -> String {
        try await Task {
            await Task.yield()
            return try Self.run(input, path: path)
        }.value
    }
}

// all mutable state is guarded by the lock, so we can safely declare `LineBuilder` as Sendable.
private class LineBuilder: @unchecked Sendable {
    let lock = NSLock()
    var lines = [String]()

    func append(_ line: String) {
        lock.lock(); defer { lock.unlock() }
        lines.append(line)
    }

    var result: String {
        lock.lock(); defer { lock.unlock() }
        return lines.joined(separator: "\n")
    }
}
