import Foundation

private let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss  "
    return formatter
}()

private struct Colors {
    static let reset = "\u{001B}[0;0m"
    static let black = "\u{001B}[0;30m"
    static let red = "\u{001B}[0;31m"
    static let green = "\u{001B}[0;32m"
    static let yellow = "\u{001B}[0;33m"
    static let blue = "\u{001B}[0;34m"
    static let magenta = "\u{001B}[0;35m"
    static let cyan = "\u{001B}[0;36m"
    static let white = "\u{001B}[0;37m"
}

/// A namespace that provides methods for expressive output from your `Job` code.
public enum Output {
    /// Print to the console and log file.
    public static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Self.output(items, separator: separator, terminator: terminator, color: nil)
    }

    /// Print to the console and log file.  The console will use a non-default color to highlight the content as a warning.
    public static func warn(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Self.output(items, separator: separator, terminator: terminator, color: Colors.yellow)
    }

    /// Print to the console and log file.  The console will use a non-default color to highlight the content as an error.
    public static func error(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Self.output(items, separator: separator, terminator: terminator, color: Colors.red)
    }

    /// Print to the console and log file.  The console will use a non-default color to highlight the content as a success.
    public static func success(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Self.output(items, separator: separator, terminator: terminator, color: Colors.green)
    }

    internal static func info(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Self.output(items, separator: separator, terminator: terminator, color: Colors.blue)
    }

    internal static func quote(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Self.output(items, separator: separator, terminator: terminator, color: Colors.cyan)
    }

    private static func output(_ items: Any..., separator: String, terminator: String, color: String?) {
        Swift.print(formatter.string(from: Date()), terminator: "")

        if let color {
            Swift.print(color, terminator: "")
        }
        Swift.print(items, separator: separator, terminator: terminator)
        if color != nil {
            Swift.print(Colors.reset, terminator: "")
        }
    }
}
