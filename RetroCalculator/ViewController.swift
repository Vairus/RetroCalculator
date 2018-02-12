//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Yannis on 31/01/2018.
//  Copyright © 2018 hAppY. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var counterLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "beep_short_on", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        counterLbl.text = "0"
        
    }

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        counterLbl.text = runningNumber
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        processOperation(operation: Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        processOperation(operation: Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        processOperation(operation: Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: UIButton) {
        processOperation(operation: Operation.Divide)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        processOperation(operation: currentOperation)
        currentOperation = Operation.Empty
    }
    
    @IBAction func onClearPressed(sender: UIButton) {
        playSound()
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        counterLbl.text = "0"
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                counterLbl.text = result
                
            }
            
            currentOperation = operation
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
    }

}

