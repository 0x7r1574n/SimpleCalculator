//
//  ViewController.swift
//  SimpleCalculator
//
//  Created by Cechi Shi on 10/21/15.
//  Copyright © 2015 Cechi Shi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var numberDisplay: UILabel!
    var previous: Double = 0
    var hasOperationPressed: Bool = false
    var currentOperation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func convert(incoming:String) -> Double {
        return NSNumberFormatter().numberFromString(incoming)!.doubleValue
    }
    
    func isInteger(double:Double) -> Bool {
        return floor(double) == double
    }
    
    func properNumberType(double: Double) -> String {
        if isInteger(double) {
            return String(Int(double))
        } else {
            // round to 8 digits precision if necessary
            return String(Double(round(1e8*double)/1e8))
        }
    }
    
    func displayAnswer() -> Void {
        switch currentOperation! {
        case "+":
            previous = previous + convert(numberDisplay.text!)
        case "−":
            previous = previous - convert(numberDisplay.text!)
        case "×":
            previous = previous * convert(numberDisplay.text!)
        case "÷":
            previous = previous / convert(numberDisplay.text!)
        case "%":
            previous = previous % convert(numberDisplay.text!)
        default:
            break
        }
        numberDisplay.text = properNumberType(previous)
    }

    @IBAction func numberPressed(sender: UIButton) {
        let digit = sender.currentTitle
        let currentNumber = numberDisplay.text
        
        if digit != "." && currentNumber == "0" {
            numberDisplay.text = digit
        }
        else if hasOperationPressed || (currentNumber == "0") {
            numberDisplay.text = digit
            hasOperationPressed = false
        }
        else if currentNumber!.rangeOfString(".") != nil && digit == "." {
            numberDisplay.text = numberDisplay.text
        }
        else if digit == "." && (hasOperationPressed || currentNumber == "0") {
            numberDisplay.text = "0."
        }
        else {
            numberDisplay.text = currentNumber! + digit!
        }
    }

    @IBAction func resetDisplay(sender: UIButton) {
        numberDisplay.text = "0"
        hasOperationPressed = false
        previous = 0
    }
    
    @IBAction func operationPressed(sender: UIButton) {
        let operation = sender.currentTitle!
        if previous == 0 {
            previous = convert(numberDisplay.text!)
        } else {
            displayAnswer()
        }
        switch operation {
        case "+":
            currentOperation = "+"
            hasOperationPressed = true
        case "−":
            currentOperation = "−"
            hasOperationPressed = true
        case "×":
            currentOperation = "×"
            hasOperationPressed = true
        case "÷":
            currentOperation = "÷"
            hasOperationPressed = true
        case "%":
            currentOperation = "%"
            hasOperationPressed = true
        default:
            break
        }
    }
    
    @IBAction func getAnswer(sender: UIButton) {
        displayAnswer()
        previous = 0
    }
}

