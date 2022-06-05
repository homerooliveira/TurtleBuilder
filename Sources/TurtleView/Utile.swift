import Foundation
import TurtleBuilder

#if os(macOS)
import AppKit

public typealias PlatformView = NSView
public typealias PlatformColor = NSColor
public typealias PlatformPath = NSBezierPath

extension NSBezierPath {

    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)

        for i in 0 ..< elementCount {
            let type = element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                continue
            }
        }

        return path
    }
}
#endif

#if os(iOS)
import UIKit

public typealias PlatformView = UIView
public typealias PlatformColor = UIColor
public typealias PlatformPath = UIBezierPath
#endif

func transalte(_ position: Point, center: CGPoint) -> CGPoint {
	let x = center.x + CGFloat(position.x)
	let y = center.y + (CGFloat(position.y) * -1)
	return CGPoint(x: x, y: y)
}
