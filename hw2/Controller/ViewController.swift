//
//  ViewController.swift
//  hw2
//
//  Created by Abdullah Genc on 30.09.2022.
//

import UIKit

//MARK: - Extension for Double type
extension Double {
    // This function removes long fraction digits from given Double variable.
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        return String(formatter.string(from: number) ?? "")
    }
}

class ViewController: UIViewController {
    
    //MARK: - Class Properties
    @IBOutlet weak var historyDisplayLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    
    //Keeps the information whether the user has finished typing numbers or not.
    private var isFinishedTypingNumber: Bool = true
    
    //Keeps the information whether the user presses the arithmetic operand or not.
    private var isTappedArithmeticButton: Bool = false

    //If the text value in the label is numeric, it is converted to double. Otherwise returns zero because input is a dot
    private var displayValue: Double {
        get {
            if let number = Double(displayLabel.text!) {
                return number
            } else {
                return .zero
            }
        }
        set {
            displayLabel.text = newValue.removeZerosFromEnd()
        }
    }
    
    private var calculator = CalculatorLogic()

    //MARK: - Button Functions
    
    //This function is created for operations that require a single number and a single operand.
    @IBAction func didTapOperandButton(_ sender: UIButton) {
        
        //The user is expected to finish entering the number when the operand is pressed.
        isFinishedTypingNumber = true
        
        calculator.setFirstNumber(displayValue)
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.operandCalculate(symbol: calcMethod) {
                if calcMethod == "AC" {
                    historyDisplayLabel.text = ""
                    calculator.setFirstNumber(nil)
                    calculator.setOperand(nil)
                    calculator.setSecondNumber(nil)
                } else {
                    historyDisplayLabel.text = "\(calcMethod) for \(displayValue) = \(result.removeZerosFromEnd())"
                    calculator.setFirstNumber(result)
                }
                displayValue = result
            }
        }
    }

    //This function is created for operations that require two numbers and a single operand.
    @IBAction func didTapArithmeticButton(_ sender: UIButton) {
        
        //The user is expected to finish entering the number when the operand is pressed.
        isFinishedTypingNumber = true
        
        //This if statement is added so that when the user repeatedly presses the arithmetic operands, the given number input is not perceived as 2 inputs.
        if isTappedArithmeticButton {
            
            if let calcMethod = sender.currentTitle {
                
                //Checking whether the variable required for the first input is nil or not.
                if calculator.getFirstNumber() == nil {
                    calculator.setFirstNumber(displayValue)
                    if calcMethod != "=" {
                        calculator.setOperand(calcMethod)
                        isTappedArithmeticButton = false
                    }
                    
                //Checking whether the variable required for the operand input is nil or not.
                } else if calculator.getOperand() == nil {
                    if calcMethod != "=" {
                        calculator.setOperand(calcMethod)
                        isTappedArithmeticButton = false
                    }
                    
                //Checking whether the variable required for the second input is nil or not.
                } else if calculator.getSecondNumber() == nil {
                    calculator.setSecondNumber(displayValue)
                    
                    //Control of obtaining a result according to the given inputs.
                    if let result = calculator.arithmeticCalculate() {
                        let firstNum = calculator.getFirstNumber()!
                        let secondNum = displayValue
                        let operand = calculator.getOperand()!
                        
                        //Adding the performed calculation to the history label.
                        historyDisplayLabel.text = "\(firstNum.removeZerosFromEnd()) \(operand) \(secondNum.removeZerosFromEnd()) = \(result.removeZerosFromEnd())"
                        
                        displayValue = result
                        calculator.setFirstNumber(result)
                        calculator.setSecondNumber(nil)
                        
                        if calcMethod == "=" {
                            calculator.setOperand(nil)
                        } else {
                            calculator.setOperand(calcMethod)
                            isTappedArithmeticButton = false
                        }
                    }
                }
            }
        }
    }
    
    //This function is created to get the number inputs entered.
    @IBAction func didTapDigitButton(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            
            //If the user clicked on the operand and stopped the number entry, the number values ​​in the label are transferred to the variable.
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                
                //bool values ​​are changed for subsequent calculations
                isTappedArithmeticButton = true
                isFinishedTypingNumber = false
            } else {
                
                //Since the input value must represent a number, it is checked that more than one dot character is not written.
                if numValue == "." && displayLabel.text!.contains(".") {
                    return
                }
                displayLabel.text! += numValue
            }
        }
    }
}

