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
        
        guard let path = Bundle.main.path(forResource: "charity", ofType:"plist") else {
            print("ERROR: could not get path to plist")
            return
        }
        
        // create an array from the contents of this file
        guard let cats = NSArray(contentsOfFile: path) else {
            print("Unable to open plist as array")
            return
        }
        
        // Set the tiles of the buttons
        topButton.setTitle((cats[0] as AnyObject) as? String, for: .normal)
        bottomButton.setTitle((cats[1] as AnyObject) as? String, for: .normal)
        
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

