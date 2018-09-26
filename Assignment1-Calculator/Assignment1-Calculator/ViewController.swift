//
//  ViewController.swift
//  Assignment1-Calculator
//
//  Created by Jose Aleixo Porpino Filho on 2018-09-20.
//  Copyright © 2018 Porpapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var userTyped = false
    private var lastButtonClicked:String? = nil;
    
    @IBOutlet weak var lblResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResult.text = "0"
    }
    
    @IBAction private func onClickClear(_ sender: UIButton) {
        userTyped = false
        calc.clear()
        resultValue = calc.result
    }
    
    @IBAction private func onClickNumbers(_ sender: UIButton) {
        let buttonText = sender.currentTitle!
        let resultText = lblResult.text!
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
        lastButtonClicked = buttonText
        userTyped = true
    }
    
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
            } else if txtValue == "-inf" {
                lblResult.text = "-∞"
            } else if txtValue == "nan" {
                lblResult.text = "Not a number"
            } else if txtValue.suffix(2) == ".0" {
                lblResult.text = String(txtValue.prefix(txtValue.count - 2))
            } else if(txtValue == ".") {
                lblResult.text = "0."
            } else {
                lblResult.text = txtValue
            }
        }
    }
    
    private let calc = Calculator()
    
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
                
                do {
                    try calc.calculate(symbol: operand)
                } catch Calculator.CalcError.math(let errorMessage) {
                    lblResult.text = errorMessage
                    lastButtonClicked = operand
                    print(errorMessage)
                    return
                } catch {
                    lblResult.text = calc.genericErrorMessage
                    lastButtonClicked = operand
                    print(error)
                    return
                }
            }
            lastButtonClicked = operand
        }
        resultValue = calc.result
    }
    
}

