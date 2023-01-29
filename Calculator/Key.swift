//
//  Key.swift
//  Calc
//
//  Created by Alex on 6/9/22.
//

import SwiftUI
import UIKit

enum KeyType {
    case number, basicOperation, otherOperation, advOperation
}

struct Key: View {
    private var text: String
    private var type: KeyType
    @Environment(\.colorScheme) var colorScheme;
    
    init(_ newVal: String, type newType: KeyType = .number) {
        text = newVal
        type = newType
    }
    
    func onBtnPress() {
        print("[\(text)]")
        Calculator.keypress(text)
        print("Contains content: \(CalState.shared.entryContainsContent)")
        print("Hanging operator: \(CalState.shared.hangingOperator)")
    }
    
    func typeToBGColor(_ type: KeyType) -> Color {
        switch (type) {
        case .number:
            return colorScheme == .dark ?
            Color(red: 0.4, green: 0.4, blue: 0.4) : // dark
            Color(red: 0.82, green: 0.82, blue: 0.82)   // light
        case .basicOperation:
            return colorScheme == .dark ?
            Color(red: 1, green: 0.6, blue: 0) :
            Color(red: 1, green: 0.7, blue: 0)
        case .otherOperation:
            return colorScheme == .dark ?
            Color(red: 0.2, green: 0.2, blue: 0.2) : // dark
            Color(red: 0.92, green: 0.92, blue: 0.92)   // light
        default:
            return Color(UIColor.systemBackground)
        }
    }

    func typeToFGColor(_ type : KeyType) -> Color {
        switch (type) {
        case .basicOperation:
            return colorScheme == .dark ?
            Color.white : Color.black
        default:
            return colorScheme == .dark ?
            Color.white : Color.black
        }
    }
    
    var body: some View {
        ZStack {
            Button(action: onBtnPress) {
                Rectangle()
                    .foregroundColor(typeToBGColor(type))
            }
            GeometryReader { geom in
                Text(text)
                    .padding(geom.size.height / 4)
                    .font(.system(size: 600))
                    .minimumScaleFactor(0.01)
                    .frame(width: geom.size.width, height: geom.size.height)
                    .foregroundColor(typeToFGColor(type))
                    .allowsHitTesting(false)
            }
        }
    }
}
