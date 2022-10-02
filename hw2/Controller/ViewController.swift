//
//  ViewController.swift
//  hw2
//
//  Created by Abdullah Genc on 30.09.2022.
//

import UIKit

extension Double {
    
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var historyDisplayLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!
    
    private var isFinishedTypingNumber: Bool = true
    private var isTappedArithmeticButton: Bool = false

    private var displayValue: Double {
        get {
            guard let number = Double(displayLabel.text!) else {
                fatalError("display label error")
            }
            return number
        }
        set {
            displayLabel.text = String(newValue.removeZerosFromEnd())
        }
    }
    
    private var calculator = CalculatorLogic()
    
    @IBAction func didTapOperandButton(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        calculator.setFirstNumber(displayValue)
        calculator.setSecondNumber(nil)
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.operandCalculate(symbol: calcMethod) {
                if calcMethod == "AC" {
                    historyDisplayLabel.text = ""
                } else {
                    historyDisplayLabel.text = "\(calcMethod) for \(displayValue) = \(result.removeZerosFromEnd())"
                }
                displayValue = result
            }
        }
        calculator.setFirstNumber(nil)
    }

    @IBAction func didTapArithmeticButton(_ sender: UIButton) {
        
        isFinishedTypingNumber = true
        
        if !isTappedArithmeticButton {
            if let calcMethod = sender.currentTitle {
                if calculator.getFirstNumber() == nil {
                    calculator.setFirstNumber(displayValue)
                    if calcMethod != "=" {
                        calculator.setOperand(calcMethod)
                        isTappedArithmeticButton = true
                    }
                } else if calculator.getOperand() == nil {
                    if calcMethod != "=" {
                        calculator.setOperand(calcMethod)
                        isTappedArithmeticButton = true
                    }
                } else if calculator.getSecondNumber() == nil {
                    calculator.setSecondNumber(displayValue)
                    if let result = calculator.arithmeticCalculate() {
                        let firstNum = calculator.getFirstNumber()!
                        let secondNum = displayValue
                        let operand = calculator.getOperand()!
                        historyDisplayLabel.text = "\(firstNum.removeZerosFromEnd()) \(operand) \(secondNum.removeZerosFromEnd()) = \(result.removeZerosFromEnd())"
                        
                        displayValue = result
                        calculator.setFirstNumber(result)
                        calculator.setSecondNumber(nil)
                        
                        if calcMethod == "=" {
                            calculator.setOperand(nil)
                        } else {
                            calculator.setOperand(calcMethod)
                            isTappedArithmeticButton = true
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func didTapDigitButton(_ sender: UIButton) {
        
        if let numValue = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel.text = numValue
                isTappedArithmeticButton = false
                isFinishedTypingNumber = false
            } else {
                if numValue == "." && displayLabel.text!.contains(".") {
                    return
                }
                displayLabel.text! += numValue
            }
        }
    }
}

