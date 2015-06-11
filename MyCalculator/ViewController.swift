//
//  ViewController.swift
//  MyCalculator
//
//  Created by Zoe on 6/10/15.
//  Copyright (c) 2015 Z.S.Z. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var input: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var allowToAddDot: Bool = true
    var operandStack = Array<Double>()
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if digit == "."{
            if allowToAddDot{
                if userIsInTheMiddleOfTypingANumber{
                    display.text = display.text! + digit
                }
                else{
                    display.text = "0" + digit
                }
                allowToAddDot = false
                userIsInTheMiddleOfTypingANumber = true
            }
        }
        else{
            if userIsInTheMiddleOfTypingANumber{
                display.text = display.text! + digit
            }
            else{
                display.text = digit
                userIsInTheMiddleOfTypingANumber = true
            }
            
        }
    }

    @IBAction func enter() {
        allowToAddDot = true
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        println("\(displayValue)")
    }
    
    var displayValue: Double{
        get{
            return (display.text! as NSString).doubleValue
        }
        set{
            display.text = "\(newValue)"
            allowToAddDot = true
            userIsInTheMiddleOfTypingANumber = false
        }
        
    }
    
    @IBAction func clear() {
        userIsInTheMiddleOfTypingANumber = false
        allowToAddDot = true
        display.text = "0"
        input.text = "0.0"
        operandStack.removeAll()
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation{
        case "×": performOperation() { $0 * $1 }
        case "÷": performOperation() { $1 / $0 }
            
        case "+": performOperation() { $0 + $1 }
            
        case "−": performOperation() { $1 - $0 }
            
        case "√": performOperationWithSingleArgument() { sqrt( $0 ) }
        case "sin": performOperationWithSingleArgument() { sin( $0 ) }
            
        case "cos": performOperationWithSingleArgument() { cos( $0 ) }
            
        case "π": piOperation()
            
        default: break
        }
        
    }
    
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperationWithSingleArgument(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func piOperation(){
        let pi = M_PI
        displayValue = pi
        enter()
    }
    
}

