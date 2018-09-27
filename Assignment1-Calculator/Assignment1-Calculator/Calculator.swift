//
//  Calculator.swift
//  Assignment1-Calculator
//
//  Created by Jose Aleixo Porpino Filho on 2018-09-22.
//  Student ID: 301005491
//
//  Version 1.0.0

import Foundation


class Calculator {
    
    private var firstNumber:Double? = nil
    
    private var storedNumberContinuousEquals:Double? = nil
    
    public var pressedEquals = false
    
    private var lastNumber = 0.0
    
    private var operatorSelected:String? = nil
    
    let genericErrorMessage = "Imaginary number"
    
    public enum CalcError:Error {
        case math(String)
    }
    
    func setNumber(_ number: Double) {
        lastNumber = number
    }
    
    func calculate(symbol: String) throws {
        switch symbol {
        case "π":
            lastNumber = Double.pi
            pressedEquals = false
        case "√":
            pressedEquals = false
            if lastNumber >= 0 {
                lastNumber = sqrt(lastNumber)
            } else {
                throw CalcError.math(genericErrorMessage)
            }
        case "cos":
            lastNumber = cos(lastNumber)
            pressedEquals = false
        case "sin":
            lastNumber = sin(lastNumber)
            pressedEquals = false
        case "%":
            if firstNumber != nil {
                lastNumber = firstNumber! * (lastNumber / 100)
            } else {
                lastNumber = lastNumber / 100
            }
            
            pressedEquals = false
        case "±":
            if lastNumber != 0 {
                lastNumber = -lastNumber
            }
            pressedEquals = false
        case "+", "-", "x", "÷":
            if !pressedEquals {
                equals()
                firstNumber = lastNumber
            }
            operatorSelected = symbol
            pressedEquals = false
        case "=":
                if pressedEquals {
                    lastNumber = storedNumberContinuousEquals!
                }
                storedNumberContinuousEquals = lastNumber
                pressedEquals = true
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
        
        if let first = firstNumber {
            switch operatorSelected {
            case "+":
                lastNumber = sum(first,lastNumber)
                firstNumber = lastNumber
            case "-":
                lastNumber = subtract(first,lastNumber)
                firstNumber = lastNumber
            case "x":
                lastNumber = multiply(first,lastNumber)
                firstNumber = lastNumber
            case "÷":
                lastNumber = divide(first,lastNumber)
                firstNumber = lastNumber
            default:
                break
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
    
    func clear(){
        storedNumberContinuousEquals = nil
        pressedEquals = false
        firstNumber = nil
        operatorSelected = nil
        setNumber(0)
    }
}
