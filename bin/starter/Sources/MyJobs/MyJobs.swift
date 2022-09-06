import Foundation
import SwiftJobs

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
