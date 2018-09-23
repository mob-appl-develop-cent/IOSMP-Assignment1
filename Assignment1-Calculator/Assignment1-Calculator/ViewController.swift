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
    
    @IBOutlet weak var lblResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResult.text = "0"
    }
    
    @IBAction private func onClickClear(_ sender: UIButton) {
        userTyped = false
        calc.firstNumber = nil
        calc.operatorSelected = nil
        calc.setNumber(0)
        resultValue = calc.result
    }
    
    @IBAction private func onClickNumbers(_ sender: UIButton) {
        let buttonText = sender.currentTitle!
        let resultText = lblResult.text!
        if userTyped {
            if !resultText.contains(".") || buttonText != "." {
                lblResult.text = resultText + buttonText
            }
        }else{
            lblResult.text = buttonText
        }
        
        userTyped = true
    }
    
    var resultValue: Double {
        get {
            return Double(lblResult.text!)!
        }
        set {
            lblResult.text = String(newValue)
        }
    }
    
    private let calc = Calculator()
    
    @IBAction private func onClickOperations(_ sender: UIButton) {
        if userTyped {
            calc.setNumber(resultValue)
            userTyped = false
        }
        
        if let operand = sender.currentTitle {
            calc.calculate(symbol: operand)
        }
        resultValue = calc.result
    }
    
    
    
    
    
    
    
    
}

