//
//  Extensions.swift
//  Calc
//
//  Created by Alex on 6/11/22.
//

import Foundation

extension String {
    var isNumber : Bool {
        get {
            return !self.isEmpty && Double(self) != nil
        }
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Double {
    func toPrettyString(addDecimal: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 10
        formatter.numberStyle = .decimal
        var result = formatter.string(from: self as NSNumber) ?? "Error"
        if (!result.contains(".") && addDecimal) {
            result += "."
        }
        return result
    }
}
