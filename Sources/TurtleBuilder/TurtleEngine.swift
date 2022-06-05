import Foundation

/// The turtle that draws graphics.
public struct Turtle {
    private var commands: [TurtleCommand]
    public private (set) lazy var lines = self.complie()
    
    /// Creates a new instance.
    /// - Parameter builder: The commands sent to the turtle.
    public init(@TurtleBuilder builder: () -> [TurtleCommand]) {
        self.commands = builder()
    }
}

extension Turtle {
    
    private static func deg2rad(_ number: Double) -> Double {
        number * .pi / 180
    }
    
    private func exec(
        _ command: TurtleCommand,
        lines: inout [[Point]],
        radian: inout Double,
        lastPoint: inout Point,
        isPenDown: inout Bool,
        macros: inout [String:[TurtleCommand]]
    ) {
        switch command {
        case .pass:
            break
        case .penUp:
            isPenDown = false
        case .penDown:
            if isPenDown == false {
                lines.append([lastPoint])
            }
            isPenDown = true
        case .center:
            let newPoint = Point(x: 0, y: 0)
            if isPenDown {
                if var lastSequence = lines.last {
                    lastSequence.append(newPoint)
                    lines[lines.count - 1] = lastSequence
                }
            }
            lastPoint = newPoint
        case .resetHeading:
            radian = Turtle.deg2rad(90)
        case .setHeading(let degree):
            radian = Turtle.deg2rad(Double(90 + degree))
        case .setPoistion(let x, let y):
            let newPoint = Point(x: x, y: y)
            if lastPoint == newPoint {
                return
            }
            if isPenDown {
                if var lastSequence = lines.last {
                    lastSequence.append(newPoint)
                    lines[lines.count - 1] = lastSequence
                }
            }
            lastPoint = newPoint
        case .forward(let length):
            var x = cos(radian)
            var y = sin(radian)
            if abs(x) == 1.0 {
                y = 0
            } else if abs(y) == 1.0 {
                x = 0
            }
            x = x * Double(length)
            y = y * Double(length)
            let newPoint = Point(x: lastPoint.x + x, y: lastPoint.y +  y)
            if isPenDown {
                if var lastSequence = lines.last {
                    lastSequence.append(newPoint)
                    lines[lines.count - 1] = lastSequence
                }
            }
            lastPoint = newPoint
        case .turn(let degree):
            let rad = Turtle.deg2rad(Double(degree))
            radian += rad
        case .loop(let count, let commands):
            for _ in 0..<count {
                for command in commands {
                    exec(command, lines: &lines,
                         radian: &radian,
                         lastPoint: &lastPoint,
                         isPenDown: &isPenDown,
                         macros: &macros)
                }
            }
        case .setMacro(let name, let commands):
            macros[name] = commands
        case .playMacro(let name):
            guard let commands = macros[name] else {
                break
            }
            for command in commands {
                exec(
                    command,
                    lines: &lines,
                    radian: &radian,
                    lastPoint: &lastPoint,
                    isPenDown: &isPenDown,
                    macros: &macros
                )
            }
        }
    }
    
    private func complie() -> [[Point]] {
        var lines: [[Point]] = []
        var radian = Turtle.deg2rad(90)
        var lastPoint = Point(x: 0, y: 0)
        var isPenDown: Bool = false
        var macros: [String: [TurtleCommand]] = [:]
        
        for command in commands {
            exec(
                command,
                lines: &lines,
                radian: &radian,
                lastPoint: &lastPoint,
                isPenDown: &isPenDown,
                macros: &macros
            )
        }
        return lines
    }
    
}

public struct Point: Equatable {
    public let x: Double
    public let y: Double
}
