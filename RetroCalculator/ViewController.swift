//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Dandre Ealy on 12/5/15.
//  Copyright © 2015 Dandre Ealy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftVal = ""
    var rightVal = ""
    var currentOperation: Operation = Operation.Empty
    var results = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputLabel.text = "0"
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
  
    @IBAction func clearCal(sender: AnyObject) {
     processOperation(Operation.Empty)
        
        outputLabel.text = "0"
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
        
        
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty {
            //runn math
            
            if runningNumber != "" {
                rightVal = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    results = "\(Double(rightVal)! * Double(leftVal)!)"
                }else if currentOperation == Operation.Divide {
                    results = "\(Double(rightVal)! / Double(leftVal)!)"
                    
                }else if currentOperation == Operation.Add {
                    results = "\(Double(rightVal)! + Double(leftVal)!)"
                    
                }else if currentOperation == Operation.Subtract {
                    results = "\(Double(rightVal)! - Double(leftVal)!)"
                    
                }else if currentOperation == Operation.Empty {
                    
                    results = ""
                  
                    
                    }
                
                leftVal = results
                
                outputLabel.text = results
            }
            
            
            
            currentOperation = op
            
            
        }else {
            leftVal = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound() {
        if  btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
}

