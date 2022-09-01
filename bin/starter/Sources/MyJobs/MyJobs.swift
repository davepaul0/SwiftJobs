import Foundation
import JobsKit

@main
struct MyJobs: JobsProvider {
    static var jobs: Jobs {
        Job("hello", description: """
        Says hello!
        """
        ) { args in
            Output.print("hello!")
        }
    }
}
