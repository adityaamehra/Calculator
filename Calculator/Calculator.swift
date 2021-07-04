//
//  Calculator.swift
//  Calculator
//
//  Created by Adityaa Mehra on 04/07/21.
//

import Foundation
class Calculator:ObservableObject{
    
    // Use to update the UI
    @Published var displayValue = "0"
    
    // Store the current operator
    var currentOp:Operator?
    
    // Current no. selected
    var currentNumber:Double? = 0
    
    // Previous no. selected
    var previousNumber:Double?
    
    // Flag for equal press
    var equaled = false
    
    // How many decimal places have been typed
    var decimalPlace = 0
    // Selects the appropriate function based on the label of the button pressed
    func buttonPressed(label:String){
        
        if label == "CE"{
            // Logic
            displayValue = "0"
            reset()
        }else if label == "="{
            equalsClicked()
        }
        else if label == "."{
            decimalClicked()
        }else if let value = Double(label){
            numberPressed(value: value)
        }else{
            operatorPressed(op: Operator(label))
        }
    }
    func setDisplayValue(number: Double){
        
        if number == floor(number){
            displayValue = "\(Int(number))"
        }else{
            let decimalPlaces = 10
            displayValue = "\(round(number * pow(10, decimalPlaces)) / pow(10, decimalPlaces))"
        }
        
    }
    //  Resets the state of the calculator
    func reset(){
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
    }
    func checkForDivision() -> Bool{
        if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0 || currentNumber == 0){
            displayValue = "Error"
            reset()
            return true
        }
        return false
    }
    func equalsClicked(){
        
        if currentOp != nil{
            // Reset the decimal place for the current number
            decimalPlace = 0
            
            // Gaurd for division by zero
            if checkForDivision(){
                return
            }
            if currentNumber != nil || previousNumber != nil {
                
                // Compute the total
                let total = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                
                // Update the first operand
                if currentNumber == nil{
                    currentNumber = previousNumber
                }
                
                // Update the second operand
                previousNumber = total
                // Set the equaled flag
                equaled = true
                // Update the UI
                setDisplayValue(number: total)
            }
        }
        
    }
    
    func decimalClicked(){
       
        if equaled{
           
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        if currentNumber == nil{
            currentNumber = 0
        }
        decimalPlace = 1
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
    }
    
    func numberPressed(value:Double){
        
        if equaled{
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        if currentNumber == nil{
            currentNumber = value / pow(10, decimalPlace)
        }else{
            if decimalPlace == 0{
                currentNumber = currentNumber! * 10 + value
            }else{
                currentNumber = currentNumber! + value / pow(10, decimalPlace)
                decimalPlace += 1
            }
        }
        setDisplayValue(number: currentNumber!)
    }
    
    func operatorPressed(op:Operator){
        
        decimalPlace = 0
        
        if equaled {
            currentNumber = nil
            equaled = false
        }
        if currentNumber != nil && previousNumber != nil{
            if checkForDivision(){
                return
            }
            let total = currentOp!.op(previousNumber!  , currentNumber!)
            previousNumber = total
            currentNumber = nil
            
            setDisplayValue(number: total)
        }else if previousNumber == nil {
            previousNumber = currentNumber
            currentNumber = nil
        }
        currentOp = op
        
    }
}

func pow(_ base:Int , _ exp:Int) -> Double{
    return pow(Double(base) , Double(exp))
    
}
