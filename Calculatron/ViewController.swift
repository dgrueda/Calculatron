//
//  ViewController.swift
//  Calculatron
//
//  Created by Diego Rueda on 09/07/15.
//  Pending to attach Open Source License
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var displayIsClear = true
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if (displayIsClear) {
            display.text = digit
            displayIsClear = false
        }
        else {
            display.text = display.text! + digit
        }
        
    }

    var operandStack = [Double]()
    
    @IBAction func enter() {
        displayIsClear = true
        operandStack.append(displayValue)
//        println(operandStack)
    }
    
    /// variable computed; cuando cambia de valor, ejecuta el set{}, cuando se lee, ejecuta el get{}
    var displayValue: Double {
        get {
            /// Utilizar directamente Double(display.text!) no funciona
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            /// En lugar de hacer cast con String(), se puede usar "\()"
            display.text = "\(newValue)"
            displayIsClear = false
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if !displayIsClear {
            enter()
        }

        switch operation {
            /*
                Opciones closure:
                    - performOperation(multiply); -> función definida en otro lugar
                    - performOperation({ (op1: Double, op2: Double) -> Double in
                        return op1 * op2 }); -> pasar la función anónima en un closure {}
                    - performOperation({ (op1, op2) -> Double in
                        return op1 * op2 }); -> Swift ya sabe el tipo de los parámetros
                    - performOperation({ (op1, op2) in op1 * op2 }); -> Swift ya sabe que se devuelve algo, y su tipo
                    - performOperation({ $0 * $1 }); -> accedes a los parámetros directamente a través del array de parámetros, sin necesidad de nombrarlos
            */
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - $0 }
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
            /// Llama a la función sobrecargada
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    /// Recibe una función como parámetro, y la ejecuta
    func performOperation(operation: (Double, Double) -> Double) {
        /// Si no te aseguras de que el array.count es > 0, el removeLast() fallará
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    /// Sobrecarga de la función para poder utilizar sqrt()
    func performOperation(operation: (Double) -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
}

