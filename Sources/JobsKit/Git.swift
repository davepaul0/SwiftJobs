import Foundation

public class Git {
    public let path: URL

    public init(path: URL) {
        self.path = path
    }

    public func status() throws -> String {
        try Command.run("git status", path: path)
    }

    @discardableResult public func delete(branch: String) throws -> String {
        try Command.run("git branch -d \(branch)", path: path)
    }
}
