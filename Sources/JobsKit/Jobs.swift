import Foundation

public struct Job {
    public let name: String
    public let description: String?
    public let isDefault: Bool
    public let action: ([String]) throws -> Void

    public init(_ name: String, description: String? = nil, isDefault: Bool = false, action: @escaping ([String]) throws  -> Void) {
        self.name = name
        self.isDefault = isDefault
        self.description = description
        self.action = action
    }
}

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
