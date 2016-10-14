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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        self.topButton.isSelected = true
        self.topButton.backgroundColor = UIColor.green
    }
    
    @IBAction func submitPressed(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.view.frame.origin.y = 0
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

