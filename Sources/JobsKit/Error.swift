import Foundation

public struct Error: Swift.Error, CustomStringConvertible {
    public let message: String
    public let file: String
    public let line: Int

    public init(_ message: String, file: String = #file, line: Int = #line) {
        self.message = message
        self.file = file
        self.line = line
    }

    public var description: String { "\(message) -- \(file), line \(line)" }
}
