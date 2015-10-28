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
    var currentOperation: String = ""
    var inventory: [String] = []
    
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
            return String(Double(round(1e8 * double) / 1e8))
        }
    }
    
    func factorial(n: Double) -> Double {
        return n == 0 ? 1.0 : n * factorial(n - 1.0)
    }
    
    func displayAnswer() -> Void {
        switch currentOperation {
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
        switch digit! {
        case ".":
            if currentNumber == "0" || hasOperationPressed {
                numberDisplay.text = "0."
                hasOperationPressed = false
            }
            else if currentNumber!.rangeOfString(".") != nil {
                numberDisplay.text = numberDisplay.text
            }
            else {
                numberDisplay.text = currentNumber! + digit!
            }
        default:
            if currentNumber == "0" || hasOperationPressed {
                numberDisplay.text = digit
                hasOperationPressed = false
            } else {
                numberDisplay.text = currentNumber! + digit!
            }
        }
    }

    @IBAction func resetDisplay(sender: UIButton) {
        numberDisplay.text = "0"
        hasOperationPressed = false
        previous = 0
    }
    
    @IBAction func operationPressed(sender: UIButton) {
        let operation = sender.currentTitle!

        switch operation {
        case "+":
            if previous == 0 {
                previous = convert(numberDisplay.text!)
            } else {
                displayAnswer()
            }
            currentOperation = "+"
            hasOperationPressed = true
        case "−":
            if previous == 0 {
                previous = convert(numberDisplay.text!)
            } else {
                displayAnswer()
            }
            currentOperation = "−"
            hasOperationPressed = true
        case "×":
            if previous == 0 {
                previous = convert(numberDisplay.text!)
            } else {
                displayAnswer()
            }
            currentOperation = "×"
            hasOperationPressed = true
        case "÷":
            if previous == 0 {
                previous = convert(numberDisplay.text!)
            } else {
                displayAnswer()
            }
            currentOperation = "÷"
            hasOperationPressed = true
        case "%":
            if previous == 0 {
                previous = convert(numberDisplay.text!)
            } else {
                displayAnswer()
            }
            currentOperation = "%"
            hasOperationPressed = true
        case "CNT":
            currentOperation = "CNT"
            inventory.append(numberDisplay.text!)
            hasOperationPressed = true
        case "AVG":
            currentOperation = "AVG"
            inventory.append(numberDisplay.text!)
            hasOperationPressed = true
        case "!":
            previous = convert(numberDisplay.text!)
            if previous > 20 {
                numberDisplay.text = "0"
            } else {
                numberDisplay.text = properNumberType(factorial(previous))
            }
            previous = 0
            currentOperation = ""
        default:
            break
        }
    }
    
    @IBAction func getAnswer(sender: UIButton) {
        switch currentOperation {
        case "CNT":
            inventory.append(numberDisplay.text!)
            numberDisplay.text = String(inventory.count)
            currentOperation = ""
        case "AVG":
            inventory.append(numberDisplay.text!)
            var sum = convert(inventory[0])
            for var i = 1; i < inventory.count; i++ {
                sum += convert(inventory[i])
            }
            let result = sum / Double(inventory.count)
            numberDisplay.text = properNumberType(result)
            currentOperation = ""
        case "+", "−", "×", "÷", "%":
            displayAnswer()
        default:
            break
        }
        previous = 0
        inventory.removeAll()
    }
}

