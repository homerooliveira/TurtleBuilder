import TurtleBuilder
import SwiftUI

#if os(macOS)
import AppKit

@available(macOS 10.15, *)
public typealias RepresentableView = NSViewRepresentable
#elseif os(iOS)
import UIKit

@available(iOS 13.0, *)
public typealias RepresentableView = UIViewRepresentable
#endif

@available(macOS 10.15, *)
@available(iOS 13.0, *)
public struct AnimatedTurtleView: RepresentableView {
    
    public let turtle: Turtle
    
    public init(@TurtleBuilder builder: () -> [TurtleCommand]) {
        self.turtle = Turtle(builder: builder)
    }
    
    public func makeUIView(context: Context) -> TurtlePlatformView {
        TurtlePlatformView(frame: .zero, turtle: turtle)
    }
    
    public func updateUIView(_ uiView: TurtlePlatformView, context: Context) {
    }
    
    public func makeNSView(context: Context) -> TurtlePlatformView {
        TurtlePlatformView(frame: .zero, turtle: turtle)
    }
    
    public func updateNSView(_ nsView: TurtlePlatformView, context: Context) {
    }
}
