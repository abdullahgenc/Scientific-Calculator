//
//  CalculatorLogic.swift
//  hw2
//
//  Created by Abdullah Genc on 1.10.2022.
//

import Foundation

struct CalculatorLogic {
    
    private var firstNumber: Double?
    private var secondNumber: Double?
    private var operand: String?

    
    func getFirstNumber() -> Double? {
        return firstNumber
    }
    func getSecondNumber() -> Double? {
        return secondNumber
    }
    func getOperand() -> String? {
        return operand
    }
    
    mutating func setFirstNumber(_ firstNumber: Double?) {
        self.firstNumber = firstNumber
    }
    mutating func setSecondNumber(_ secondNumber: Double?) {
        self.secondNumber = secondNumber
    }
    mutating func setOperand(_ operand: String?) {
        self.operand = operand
    }
    
     
    func operandCalculate(symbol: String) -> Double? {
        
        if let num1 = firstNumber {
            
            switch symbol {
            case "+/-":
                return num1 * -1
            case "AC":
                return .zero
            case "%" :
                return num1 * 0.01
            default:
                print(".")
            }
        }
        return nil
    }
    
    func arithmeticCalculate() -> Double? {
            
        switch operand {
        case "+":
            return firstNumber! + secondNumber!
        case "-":
            return firstNumber! - secondNumber!
        case "x":
            return firstNumber! * secondNumber!
        case "/":
            return firstNumber! / secondNumber!
        default:
            fatalError("passed operation error")
        }
        
    }
    
}
