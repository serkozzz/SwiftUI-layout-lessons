// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A macro that produces both a value and a string containing the
/// source code that generated the value. For example,
///
///     #stringify(x + y)
///
/// produces a tuple `(x + y, "x + y")`.
@freestanding(expression)
public macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "MyMacroPackageMacros", type: "StringifyMacro")

// Этот макрос добавляет членов (member-attached), а не «peer»
@attached(member, names: named(printMethods))
public macro PrintMethods() = #externalMacro(
    module: "MyMacroPackageMacros",
    type: "PrintMethodsMacro"
)
