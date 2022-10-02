//
//  CalculatorLogic.swift
//  hw2
//
//  Created by Abdullah Genc on 1.10.2022.
//

import Foundation

struct CalculatorLogic {
    
    //MARK: - Properties
    //Variables required for calculation.
    private var firstNumber: Double?
    private var secondNumber: Double?
    private var operand: String?

    //getter and setter functions.
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
    
    //MARK: - Functions for Calculation
    //The function that finds the nth root of the input value.
    private func nthRoot(_ value: Double, _ n: Double) -> Double {
        let multipleOf2 = abs(n.truncatingRemainder(dividingBy: 2)) == 1
        return value < 0 && multipleOf2 ? -pow(-value, 1/n) : pow(value, 1/n)
    }
    
    //The function that finds the factorial of the input value.
    private func factorial(_ N: Double) -> Double {
        if Int(exactly: N) != nil {
            var mult = N
            var retVal: Double = 1.0
            while mult > 0.0 {
                retVal *= mult
                mult -= 1.0
            }
            return retVal
        } else {
            return .zero
        }
    }
    
    //Functions for operations that require a single number and a single operand.
    func operandCalculate(symbol: String) -> Double? {
        if let num1 = firstNumber {
            switch symbol {
            case "+/-":
                return num1 * -1
            case "AC":
                return .zero
            case "%" :
                return num1 * 0.01
            case "x²" :
                return pow(num1, 2)
            case "x³" :
                return pow(num1, 3)
            case "√x" :
                return sqrt(num1)
            case "∛x" :
                return nthRoot(num1, 3)
            case "1/x" :
                return 1 / num1
            case "x!" :
                return factorial(num1)
            case "log₂" :
                return log2(num1)
            default:
                print("passed operand error")
            }
        }
        return nil
    }
    
    //Functions for operations that require two numbers and a single operand.
    func arithmeticCalculate() -> Double? {
        switch operand {
        case "+":
            return firstNumber! + secondNumber!
        case "-":
            return firstNumber! - secondNumber!
        case "x":
            return firstNumber! * secondNumber!
        case "÷":
            return firstNumber! / secondNumber!
        case "xʸ":
            return pow(firstNumber!, secondNumber!)
        case "ʸ√x":
            return nthRoot(secondNumber!, firstNumber!)
        default:
            fatalError("passed arithmetic operand error")
        }
    }
}
