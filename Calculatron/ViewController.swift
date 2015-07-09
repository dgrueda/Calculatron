//
//  ViewController.swift
//  Calculatron
//
//  Created by Diego Rueda on 09/07/15.
//  Copyright (c) 2015 Diego Rueda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var displayIsClear: Bool = true
    
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

}

