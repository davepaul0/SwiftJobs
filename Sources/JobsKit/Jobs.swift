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

//    public func execute(_ name: String) throws {
//        guard let job = dict[name] else {
//            throw Error("Tried to execute job named \(name) but job doesn't exist.")
//        }
//        try job.action([]) // TODO: get params from somewhere I suppose
//    }
}
