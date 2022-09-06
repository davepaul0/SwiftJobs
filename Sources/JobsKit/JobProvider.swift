import Foundation

/// A Builder that creates a `Jobs` object from multiple `Job` instances.
@resultBuilder public struct JobsBuilder {
    public static func buildBlock(_ components: Job...) -> [Job] {
        Array(components)
    }

    public static func buildFinalResult(_ component: [Job]) -> Jobs {
        var dict = [String: Job]()
        for job in component {
            dict[job.name] = job
        }
        return .init(dict: dict)
    }
}

/// Provides `Jobs` to the SwiftJobs runtime.
/// Your `MyJobs` project must declare an object that adopts the `JobsProvider` protocol.
public protocol JobsProvider {
    @JobsBuilder static var jobs: Jobs { get }
}

public extension JobsProvider {
    static func main() {
        let jobs = Self.jobs
        let args = CommandLine.arguments

        guard args.count > 1, args[1] == "run" else {
            // list the available jobs
            Output.success("Here are the available jobs:\n")
            jobs.listAll()
            return
        }

        guard args.count > 2 else {
            // It's a "run" operation, but we don't have a job name.
            Output.error("Please specify a job name. Here are the available jobs:\n")
            jobs.listAll()
            exit(1)
        }

        let name = args[2]

        guard let job = jobs.dict[name] else {
            Output.error("No job found for name: \(name)")
            exit(1)
        }

        Output.print("Running job \"\(name)\"")
        // We have a job to run!  But before we do...
        // ... set the current path up one step, to the user's project folder
        let newPath = (FileManager.default.currentDirectoryPath as NSString).deletingLastPathComponent
        FileManager.default.changeCurrentDirectoryPath(newPath)

        do {
            try job.action(Array(args.suffix(from: 3)))
        } catch {
            Output.error("Job \(name) failed with error:")
            Output.error(error)
            exit(1)
        }
    }
}
