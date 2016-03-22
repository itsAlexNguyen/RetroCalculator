//
//  ViewController.swift
//  retro-calculator
//
//  Created by Alex Nguyen on 2016-01-04.
//  Copyright © 2016 Alex Nguyen. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    enum Operation: String {
        case Divide = "/"
        case Mutliply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    @IBAction func onDividePress(sender: AnyObject) {
        processOperator(Operation.Divide)
    }
    
    @IBAction func onMultiplyPress(sender: AnyObject) {
        processOperator(Operation.Mutliply)
    }
    
    @IBAction func onSubtractPress(sender: AnyObject) {
        processOperator(Operation.Subtract)
    }
    
    @IBAction func onAddPress(sender: AnyObject) {
        processOperator(Operation.Add)
    }
    
    @IBAction func onEqualPress(sender: AnyObject) {
        processOperator(currentOperation)
        
    }
    @IBAction func numberPressed(btn: UIButton!) {
        
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLabel.text = runningNumber
        
    }

    @IBAction func onClearPressed(sender: AnyObject) {
        outputLabel.text = "0"
        runningNumber = "0"
        rightValString = "0"
        leftValString = "0"
        
    }
    func processOperator(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Mutliply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                }
            
                leftValString = result
                outputLabel.text = result
            }
            currentOperation = op
        
        } else {
            //This is the first time an operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func playSound(){
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }

}

