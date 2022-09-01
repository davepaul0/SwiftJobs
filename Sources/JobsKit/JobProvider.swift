import Foundation

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

public protocol JobsProvider {
    @JobsBuilder static var jobs: Jobs { get }
}

public extension JobsProvider {
    static func main() {
        let jobs = Self.jobs
        let args = CommandLine.arguments

        guard args.count > 1 else {
            // list the available jobs
            Output.success("No job specified. Here are the available jobs:\n")
            for job in jobs.dict.values {
                Output.success(job.name)
                if let desc = job.description {
                    Output.print(desc)
                }
                Output.print("")
            }
            return
        }

        let name = args[1]

        guard let job = jobs.dict[name] else {
            Output.error("No job found for name: \(name)")
            return
        }

        // We have a job to run!  But before we do...
        // ... set the current path up one step, to the user's project folder
        let newPath = (FileManager.default.currentDirectoryPath as NSString).deletingLastPathComponent
        FileManager.default.changeCurrentDirectoryPath(newPath)

        do {
            try job.action(Array(args.suffix(from: 2)))
        } catch {
            Output.error("Job \(name) failed with error:")
            Output.error(error)
        }
    }
}