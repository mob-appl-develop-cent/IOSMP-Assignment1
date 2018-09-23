//
//  Calculator.swift
//  Assignment1-Calculator
//
//  Created by Aleixo Porpino Filho on 2018-09-22.
//  Copyright © 2018 Porpapps. All rights reserved.
//

import Foundation


class Calculator {
    
    var firstNumber:Double? = nil;
    
    private var lastNumber = 0.0
    
    var operatorSelected:String? = nil
    
    func setNumber(_ number: Double) {
        lastNumber = number
    }
    
    func calculate(symbol: String) {
        switch symbol {
        case "π":
            lastNumber = Double.pi
        case "√":
            lastNumber = sqrt(lastNumber)
        case "cos":
            lastNumber = cos(lastNumber)
        case "sin":
            lastNumber = sin(lastNumber)
        case "±":
            lastNumber = -lastNumber
        case "+", "-", "x", "÷":
            equals()
            operatorSelected = symbol
            firstNumber = lastNumber
        case "=":
            equals();
        default:
            break
        }
    }
    
    var result: Double {
        get {
            return lastNumber
        }
    }
    
    private func equals() {
        if operatorSelected != nil {
            if let first = firstNumber {
                switch operatorSelected {
                case "+":
                    lastNumber = sum(first,lastNumber)
                case "-":
                    lastNumber = subtract(first,lastNumber)
                case "x":
                    lastNumber = multiply(first,lastNumber)
                case "÷":
                    lastNumber = divide(first,lastNumber)
                default:
                    break
                }
            }
        }
    }
    
    private func sum(_ value1:Double,_ value2:Double) -> Double {
        return value1 + value2;
    }
    private func subtract(_ value1:Double,_ value2:Double) -> Double {
        return value1 - value2;
    }
    private func multiply(_ value1:Double,_ value2:Double) -> Double {
        return value1 * value2;
    }
    private func divide(_ value1:Double,_ value2:Double) -> Double {
        return value1 / value2;
    }
}
