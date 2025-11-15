import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
///     #stringify(x + y)
///
///  will expand to
///
///     (x + y, "x + y")
public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.arguments.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "(\(argument), \(literal: argument.description))"
    }
}


public struct PrintMethodsMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf decl: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {


        let memberBlock: MemberBlockSyntax?
        if let classDecl = decl.as(ClassDeclSyntax.self) {
            memberBlock = classDecl.memberBlock
        } else if let structDecl = decl.as(StructDeclSyntax.self) {
            memberBlock = structDecl.memberBlock
        } else {
            return []
        }

        // Собираем имена методов, уже объявленных в типе
        let methodNames: [String] = memberBlock?.members.compactMap { member in
            guard let fn = member.decl.as(FunctionDeclSyntax.self) else { return nil }
            return fn.identifier.text
        } ?? []

        let joined = methodNames.joined(separator: ", ")

        // Генерируем обычный (экземплярный) метод
        let printMethod: DeclSyntax = """
        func printMethods() {
            print("\\\(raw: joined)")
        }
        """

        return [printMethod]
    }
}

@main
struct MyMacroPackagePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StringifyMacro.self,
        PrintMethodsMacro.self
    ]
}
