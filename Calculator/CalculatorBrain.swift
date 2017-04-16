//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Yaseen Majeed on 09/04/17.
//  Copyright © 2017 Yaseen Majeed. All rights reserved.
//

import Foundation

class calculatorBrain{
    private var accumulator = 0.0
    
    func setOperand (operand: Double)
    {
        accumulator = operand
    }
    
    
    
    private var operations: Dictionary<String , Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "sin" : Operation.UnaryOperation(sin),
        
        "=" : Operation.Equals
        
    ]
    
    
    
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double ,Double) -> Double)
        case Equals
    }
    
    
    
    
    
    
 func performOperation(symbol : String)
      {
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperation(binaryFunction: function , firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation(){
        if pending != nil{
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        var binaryFunction : (Double,Double) -> Double
        var firstOperand: Double
    }
    
    var result : Double
        {
        get
        {
            return accumulator
        }
    }
}
