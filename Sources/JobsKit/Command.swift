import Foundation

/// A namespace for executing shell commands inside of a `Job`.
public enum Command {

    /// Runs the given shell command, blocking the current thread until the command completes.
    @discardableResult public static func run(_ input: String, path: URL? = nil) throws -> String {
        let task = Process()
        let pipe = Pipe()

        task.currentDirectoryURL = path
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", input]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil

        try task.run()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        task.waitUntilExit()

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


