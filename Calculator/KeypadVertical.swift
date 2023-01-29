//
//  KeypadVertical.swift
//  Calc
//
//  Created by Alex on 6/9/22.
//

import SwiftUI

struct KeypadVertical: View {
    @ObservedObject var calState = CalState.shared
    
    let cols = [
        GridItem(spacing: 1, alignment: .center),
        GridItem(spacing: 1, alignment: .center),
        GridItem(spacing: 1, alignment: .center),
        GridItem(spacing: 1, alignment: .center)
    ]
    
    var body: some View {
//        LazyVGrid(columns: cols, spacing: 2) {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 2) {
                HStack(alignment: .bottom, spacing: 2) {
                    Key(calState.hangingOperator || calState.entryContainsContent ? "C" : "AC", type: .otherOperation)
                    Key("⁺⁄₋", type: .otherOperation)
                    Key("%", type: .otherOperation)
                    Key("÷", type: .basicOperation)
                }
                HStack(spacing: 2) {
                    Key("7")
                    Key("8")
                    Key("9")
                    Key("×", type: .basicOperation)
                }
                HStack(spacing: 2) {
                    Key("4")
                    Key("5")
                    Key("6")
                    Key("−", type: .basicOperation)
                }
                HStack(spacing: 2) {
                    Key("1")
                    Key("2")
                    Key("3")
                    Key("+", type: .basicOperation)
                }
                HStack(spacing: 2) {
                    Key("0")
                        .frame(width: geo.size.width*0.5 - 1)
                    Key(".")
                    Key("=", type: .basicOperation)
                }
            }
        }
    }
}
