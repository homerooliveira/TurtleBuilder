import Foundation

/// The commands for `Turtle`.
public enum TurtleCommand {
    /// Does nothing.
    case pass
    /// Center the turtle.
    case center
    /// Reset the direction of the turtle.
    case resetHeading
    /// Set the direction of the turtle.
    case setHeading(Int)
    /// Set the position of the turtle.
    case setPoistion(Double, Double)
    /// Pen up.
    case penUp
    /// Pen down.
    case penDown
    /// Turn left to given angle.
    case turn(Int)
    /// Move forward.
    case forward(Int)
    /// Do a looping.
    case loop(Int, [TurtleCommand])
    /// Set a macro.
    case setMacro(String, [TurtleCommand])
    /// Play a macro.
    case playMacro(String)
}

public typealias TurtlePoint = (Double, Double)

/// Do nothing.
public func pass() -> TurtleCommand { .pass }

/// Center the turtle.
public func center() -> TurtleCommand { .center }

/// Reset the direction of the turtle.
public func resetHeading() -> TurtleCommand { .resetHeading }

/// An alias of `resetHeading`
public let resetH = resetHeading

/// Set the direction of the turtle.
public func setHeading(_ degree: Int) -> TurtleCommand { .setHeading(degree) }

/// An alias of `setHeading`
public let setH = setHeading

/// Set the position of the turtle.
public func setPosition(_ x: Double, _ y: Double) -> TurtleCommand { .setPoistion(x, y) }

/// Move the turtle without drawing a line.
public func penUp() -> TurtleCommand { .penUp }

/// Move the turtle with drawing a line.
public func penDown() -> TurtleCommand { .penDown }

/// Turn left to the given angle.
/// - Parameter angle: The angle.
public func left(_ angle: Int) -> TurtleCommand { .turn(angle) }

/// An alias of `left`
public let lt = left

/// Turn right to the given angle.
/// - Parameter angle: The angle.
public func right(_ angle: Int) -> TurtleCommand { .turn(angle * -1) }

/// An alias of `right`
public let rt = right

/// Move forward.
/// - Parameter length: How long do we move.
public func forward(_ length:Int) -> TurtleCommand { .forward(length) }

/// An alias of `forward`.
public let fd = forward

/// Run a loop.
/// - Parameter repeatCount: How many times do we repeat.
/// - Parameter builder: The commands to run.
public func loop(_ repeatCount: Int, @TurtleBuilder builder: () -> [TurtleCommand]) -> TurtleCommand {
    .loop(repeatCount, builder())
}

/// An alias of `loop`.
public let `repeat` = loop

/// Set a macro.
/// - Parameter name: Name of the macro.
/// - Parameter builder: The commands to run.
public func setMacro(_ name: String, @TurtleBuilder builder: () -> [TurtleCommand]) -> TurtleCommand {
    .setMacro(name, builder())
}

/// Play a macro.
/// - Parameter name: Name of the macro.
public func playMacro(_ name: String) -> TurtleCommand {
    .playMacro(name)
}
