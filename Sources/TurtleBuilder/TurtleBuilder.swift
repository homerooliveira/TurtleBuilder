import CoreGraphics
import Foundation

@resultBuilder
public struct TurtleBuilder {
    
    public static func buildEither(first commands: [TurtleCommand]) -> [TurtleCommand] {
        commands
    }
    
    public static func buildEither(second commands: [TurtleCommand]) -> [TurtleCommand] {
        commands
    }
    
    public static func buildBlock(_ commands: [TurtleCommand]...) -> [TurtleCommand] {
        commands.flatMap { $0 }
    }
    
    public static func buildOptional(_ command: TurtleCommand?) -> [TurtleCommand] {
        [command ?? .pass]
    }
    
    public static func buildExpression(_ expression: TurtleCommand) -> [TurtleCommand] {
        [expression]
    }
    
    public static func buildExpression(_ expression: [TurtleCommand]) -> [TurtleCommand] {
        expression
    }
    
    public static func buildArray(_ components: [[TurtleCommand]]) -> [TurtleCommand] {
        components.flatMap { $0 }
    }
}
