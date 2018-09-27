//
//  ViewController.swift
//  Assignment1-Calculator
//  App Description: A simple calculator with all basic operations with additional
//  cosine, sine, square root and PI.
//
//  Created by Jose Aleixo Porpino Filho on 2018-09-22.
//  Student ID 301005491
//
//  Version 1.0.0

import UIKit


// Control class of the main view calculator
class ViewController: UIViewController {
    private var userTyped = false
    private var lastButtonClicked:String? = nil;
    private let calc = Calculator()
    
    @IBOutlet weak var lblResult: UILabel!
    
    // Set number 0 in the calculator label in the begining of load
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResult.text = "0"
    }
    
    // Clear event method reset all the calculator operations
    @IBAction private func onClickClear(_ sender: UIButton) {
        userTyped = false
        calc.clear()
        resultValue = calc.result
    }
    
    // Numbers and point event handler
    @IBAction private func onClickNumbers(_ sender: UIButton) {
        let buttonText = sender.currentTitle!
        let resultText = lblResult.text!
        // Verify and set the maxlength of the calculator to 9
        if resultText.count <= 9 {
            if userTyped {
                if !resultText.contains(".") || buttonText != "." {
                    lblResult.text = resultText + buttonText
                }
            } else {
                if buttonText == "." {
                    lblResult.text = "0."
                } else {
                    lblResult.text = buttonText
                }
            }
        }
        lastButtonClicked = buttonText
        userTyped = true
            
    }
    
    // Operations event handler
    @IBAction private func onClickOperations(_ sender: UIButton) {
        if userTyped {
            calc.setNumber(resultValue)
            userTyped = false
        }
        if let operand = sender.currentTitle {
            if (lastButtonClicked != operand ||
                (operand == "=" || operand == "π"
                    || operand == "√" || operand == "±"
                    || operand == "cos" || operand == "sin")) {
                
                // Exception handle to prevent crash
                do {
                    try calc.calculate(symbol: operand)
                } catch Calculator.CalcError.math(let errorMessage) {
                    lblResult.text = errorMessage
                    lastButtonClicked = operand
                    print(errorMessage)
                    userTyped = false
                    calc.clear();
                    return
                } catch {
                    lblResult.text = calc.imaginaryNumberErrorMessage
                    lastButtonClicked = operand
                    print(error)
                    calc.clear();
                    userTyped = false
                    return
                }
            }
            lastButtonClicked = operand
        }
        resultValue = calc.result
    }
    
    // get and set with some validations of the result value
    var resultValue: Double {
        get {
            if lblResult.text == "."{
                return 0.0
            } else {
                return Double(lblResult.text!)!
                
            }
        }
        set {
            let txtValue = String(newValue)
            if txtValue == "inf" {
                lblResult.text = "∞"
                calc.clear();
                userTyped = false
            } else if txtValue == "-inf" {
                lblResult.text = "-∞"
                calc.clear();
                userTyped = false
            } else if txtValue == "nan" {
                lblResult.text = "Not a number"
                calc.clear();
                userTyped = false
            } else if txtValue.suffix(2) == ".0" {
                lblResult.text = String(txtValue.prefix(txtValue.count - 2))
            } else if(txtValue == ".") {
                lblResult.text = "0."
            } else {
                lblResult.text = txtValue
            }
        }
    }
    
}

