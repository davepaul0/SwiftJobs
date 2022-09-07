import Foundation

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
    public static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(items, separator: separator, terminator: terminator)
    }

    public static func warn(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(Colors.yellow, terminator: "")
        Swift.print(items, separator: separator, terminator: terminator)
        Swift.print(Colors.reset, terminator: "")
    }

    public static func error(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(Colors.red, terminator: "")
        Swift.print(items, separator: separator, terminator: terminator)
        Swift.print(Colors.reset, terminator: "")
    }

    public static func success(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(Colors.green, terminator: "")
        Swift.print(items, separator: separator, terminator: terminator)
        Swift.print(Colors.reset, terminator: "")
    }


    internal static func info(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(Colors.blue, terminator: "")
        Swift.print(items, separator: separator, terminator: terminator)
        Swift.print(Colors.reset, terminator: "")
    }

    internal static func quote(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(Colors.cyan, terminator: "")
        Swift.print(items, separator: separator, terminator: terminator)
        Swift.print(Colors.reset, terminator: "")
    }
}
