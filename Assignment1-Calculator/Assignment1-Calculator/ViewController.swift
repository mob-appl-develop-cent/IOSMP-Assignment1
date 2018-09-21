//
//  ViewController.swift
//  Assignment1-Calculator
//
//  Created by Aleixo Porpino Filho on 2018-09-20.
//  Copyright © 2018 Porpapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblResult.text = ""
    }

    @IBAction func onClickClear(_ sender: UIButton) {
        lblResult.text = ""
    }
    
    @IBAction func onClickNumbers(_ sender: UIButton) {
        let buttonText = (sender as UIButton).title(for: .selected)!
        
        lblResult.text = lblResult.text! + buttonText
        
    }
}

