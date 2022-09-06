import Foundation

/// A `Job` is a basic unit of work that SwiftJobs can execute.
/// Your `MyJobs` instance will provide `Job` items to SwiftJobs via the `JobsProvider` protocol.
/// You can then execute those `Job` items via the `swiftjobs` command line executable.
public struct Job {
    public let name: String
    public let description: String?
    public let isDefault: Bool
    public let action: ([String]) async throws -> Void

    private init(_ name: String, description: String? = nil, isDefault: Bool = false, action: @escaping ([String]) async throws -> Void) {
        self.name = name
        self.isDefault = isDefault
        self.description = description
        self.action = action
    }

    public init(_ name: String, description: String? = nil, isDefault: Bool = false, action: @escaping ([String]) throws  -> Void) {
        self.name = name
        self.isDefault = isDefault
        self.description = description
        self.action = action
    }

    public static func async(_ name: String, description: String? = nil, isDefault: Bool = false, action: @escaping ([String]) async throws -> Void) -> Job {
        return .init(name, description: description, isDefault: isDefault, action: action)
    }
}

/// A collection of multiple `Job` instances.
public struct Jobs {
    internal let dict: [String: Job]

    internal func listAll() {
        for job in dict.values {
            Output.success(job.name)
            if let desc = job.description {
                Output.print(desc)
            }
            Output.print("")
        }
    }
}
