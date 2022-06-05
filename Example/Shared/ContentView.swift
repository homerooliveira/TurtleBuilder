//
//  ContentView.swift
//  Shared
//
//  Created by Homero Oliveira on 05/06/22.
//

import TurtleBuilder
import TurtleView
import SwiftUI

struct ContentView: View {
    var body: some View {
        AnimatedTurtleView {
            penDown()
            
            for _ in 0..<20 {
                for _ in 0..<180 {
                    forward(25)
                    right(20)
                }
                right(18)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
