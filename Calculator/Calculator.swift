//
//  Calculator.swift
//  Calc
//
//  Created by Alex on 6/11/22.
//
import SwiftUI

class CalState: ObservableObject {
    static let shared = CalState()
    @Published public var upper: String = ""
    @Published public var lower: String = "0"
    @Published public var entryContainsContent = false
    @Published public var hangingOperator = false
    public var operations = Array<String>() { // +−×÷
        didSet {
            upper = ""
            for i in 0..<numbers.count {
                upper += "\(Double(numbers[i])!.toPrettyString()) \(operations[safe: i] ?? "") "
            }
            print(upper)
        }
    }
    public var numbers = Array<String>()
    
    public var accumulator: Double? {
        get {
            var a = 0.0
            for i in 0..<numbers.count {
                if i == 0 {
                    a = Double(numbers[i])!
                    continue
                }
                if let op = operations[safe: i-1] {
                    switch (op) {
                    case "+":
                        a += Double(numbers[i])!
                    case "−":
                        a -= Double(numbers[i])!
                    case "×":
                        a *= Double(numbers[i])!
                    case "÷":
                        a /= Double(numbers[i])!
                    default:
                        print("Invalid arithmetic operator found!")
                        return nil
                    }
                }
            }
            return a
        }
    }
    public var accumulatorString: String {
        if let aDouble = CalState.shared.accumulator {
            return aDouble.toPrettyString()
        }
        return "Error"
    }
    
    var lowerDisplay: String {
        set {
            if (newValue.isEmpty) {
                lower = "0"
            } else {
                lower = newValue
            }
        }
        get { return lower }
    }
    var upperDisplay: String {
        set { upper = newValue }
        get { return upper }
    }
}

struct Calculator {
    static let ARITHMETIC_SET = CharacterSet(charactersIn: "+−×÷")
    
    static var entryBuffer = "" {
        didSet {
            CalState.shared.lowerDisplay = Double(entryBuffer)?.toPrettyString(addDecimal: entryBuffer.contains(".")) ?? entryBuffer
        }
    }
    
    static func keypress(_ button: String) {
        // (all) clear
        if (button == "C" || button == "AC") {
            if (CalState.shared.hangingOperator && button == "C") {
                entryBuffer = CalState.shared.numbers.removeLast()
                CalState.shared.operations.removeLast()
                CalState.shared.entryContainsContent = true
                CalState.shared.hangingOperator = false
                return
            }
            
            // C
            entryBuffer = ""
            CalState.shared.entryContainsContent = false
            
            if (button == "AC") {
                CalState.shared.numbers.removeAll()
                CalState.shared.operations.removeAll()
            }
            return
        }
        
        // number entry
        if (button.isNumber) {
            if ((button == "0" && !entryBuffer.isEmpty) ||
                button != "0") {
                entryBuffer += button
            }
            CalState.shared.entryContainsContent = true
            CalState.shared.hangingOperator = false
            return
        }
        
        // decimal
        if (button == "." && !entryBuffer.contains(".")) {
            entryBuffer += entryBuffer.isEmpty ? "0." : "."
            CalState.shared.entryContainsContent = true
            return
        }
        
        // div. by 100 in place
        if button == "%" {
            if var n = Double(entryBuffer) {
                n /= 100
                entryBuffer = n.toPrettyString()
            }
        }
        
        // arithmetic operations
        if (button.rangeOfCharacter(from: ARITHMETIC_SET) != nil) {
            if (CalState.shared.hangingOperator) {
                // restore number
                entryBuffer = CalState.shared.numbers.removeLast()
                CalState.shared.entryContainsContent = true
                // remove operator
                if (CalState.shared.hangingOperator) {
                    CalState.shared.operations.removeLast()
                }
            }
            
            if !entryBuffer.isEmpty && entryBuffer.isNumber {
                CalState.shared.numbers.append(entryBuffer)
                entryBuffer = ""
                
                CalState.shared.operations.append(button)
                CalState.shared.lowerDisplay = CalState.shared.accumulatorString
                
                CalState.shared.entryContainsContent = false
                CalState.shared.hangingOperator = true
            }
            return
        }
        
        // equal
        if (button == "=") {
            if (CalState.shared.entryContainsContent) {
                CalState.shared.numbers.append(entryBuffer)
            }
            if (CalState.shared.hangingOperator) {
                CalState.shared.operations.removeLast()
            }
            let ans = CalState.shared.accumulatorString
            keypress("AC")
            CalState.shared.lowerDisplay = ans
        }
    }
}

