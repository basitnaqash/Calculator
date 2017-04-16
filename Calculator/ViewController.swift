//
//  ViewController.swift
//  Calculator
//
//  Created by Yamin Hameed on 09/04/17.
//  Copyright © 2017 Yamin Hameed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsIntheMiddleOfTyping = false
    
    @IBAction private func touchDigit(_ sender: UIButton){
        let digit = sender.currentTitle!
        if userIsIntheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else{
            display.text = digit
            
        }
        userIsIntheMiddleOfTyping = true
    }
    
    
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    
    private var brain = calculatorBrain()
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsIntheMiddleOfTyping{
            brain.setOperand(operand: displayValue)
            userIsIntheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle
        {
            brain.performOperation(symbol: mathematicalSymbol)
            
        }
        displayValue = brain.result
        
    }
    
}




