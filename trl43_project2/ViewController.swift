//
//  ViewController.swift
//  trl43_project2
//
//  Created by Locker,Todd on 10/8/16.
//  Copyright © 2016 Locker,Todd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    @IBOutlet weak var message: UITextView!
    @IBOutlet var wholeView: UIView!
    @IBOutlet var mainViewTapped: UITapGestureRecognizer!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var amountTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let path = Bundle.main.path(forResource: "charity", ofType:"plist") else {
            print("ERROR: could not get path to plist")
            return
        }
        
        // Create an array from the contents of this file
        guard let charities = NSArray(contentsOfFile: path) else {
            print("Unable to open plist as array")
            return
        }
        
        // Set the tiles of the buttons
        self.topButton.setTitle((charities[0] as AnyObject) as? String, for: .normal)
        self.bottomButton.setTitle((charities[1] as AnyObject) as? String, for: .normal)
        
        // shifts the view up for space for the keyboard
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil) {
            
            notification in
            
            print("HEREEEEEEEEEEEE\(notification.description)")
            
            // find the size of the keyboard
            guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else {
                print("ERROR: Unable to get keyboard size")
                return
            }
            
            // move the whole thing up
            self.view.frame.origin.y = -keyboardSize.height
        }
        
        
        // shift the view back down
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil) {
            
            notification in
            
            print("THEREEEEEEEEEEEEEE\(notification.description)")
            
            // move back to original position
            self.view.frame.origin.y = 0
        }
        
        
    }
    
    @IBAction func topButtonPressed(_ sender: UIButton) {
        
        if(self.topButton.isSelected) {
            self.bottomButton.isUserInteractionEnabled = true
            self.bottomButton.isHidden = false
            self.topButton.layer.cornerRadius = 0
            self.topButton.isSelected = false
        }else {
            self.bottomButton.isUserInteractionEnabled = false
            self.bottomButton.isHidden = true
            self.topButton.layer.cornerRadius = 50
            self.topButton.isSelected = true
        }
    }
    
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        if(self.bottomButton.isSelected) {
            self.topButton.isUserInteractionEnabled = true
            self.topButton.isHidden = false
            self.bottomButton.layer.cornerRadius = 0
            self.bottomButton.isSelected = false
        }else {
            self.topButton.isUserInteractionEnabled = false
            self.topButton.isHidden = true
            self.bottomButton.layer.cornerRadius = 50
            self.bottomButton.isSelected = true
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        self.amountTextField.text = sender.value.description
    }
    
    @IBAction func submitPressed(_ sender: AnyObject) {
        self.submitButton.isUserInteractionEnabled = false
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
        self.loadingIndicator.startAnimating()
        var time = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.loadingIndicator.stopAnimating()
            self.submitButton.setTitle("Thank You!", for: .normal)
            time = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.submitButton.setTitle("Submit", for: .normal)
                self.submitButton.isUserInteractionEnabled = true
            }
        }
    }
    
    @IBAction func mainViewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func messageTapped(_ sender: UITapGestureRecognizer) {
        message.becomeFirstResponder()
        message.textColor = UIColor.black
        message.selectedTextRange = message.textRange(from: message.beginningOfDocument, to: message.endOfDocument)
    }
    
}

