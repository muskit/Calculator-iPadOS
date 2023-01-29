//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Alex on 1/29/23.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct CalculatorPreviews : PreviewProvider {
    static var previews: some View {
            ContentView()
            .preferredColorScheme(.dark)
        }
}
