//
//  ViewController.swift
//  TestingSyndicate iOS
//
//  Created by Matthew Rooth on 12/07/2016.
//  Copyright © 2016 Matthew Rooth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var passcodeInput: UITextField!
    
    static let MAX_PASSCODE_LENGTH: Int = 4
    static let CORRECT_PASSCODE: String = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passcodeInput.delegate = self
        passcodeInput.addTarget(self, action: #selector(textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= LoginViewController.MAX_PASSCODE_LENGTH
    }
    
    func textFieldDidChange(textField: UITextField) {
        let passcodeEntered: String! = textField.text ?? ""
        if (passcodeEntered.characters.count == LoginViewController.MAX_PASSCODE_LENGTH) {
            if (passcodeEntered == LoginViewController.CORRECT_PASSCODE) {
                let homeViewController = storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
                navigationController?.pushViewController(homeViewController, animated: false)
            } else {
                textField.text = ""
                let alertController = UIAlertController(title: "Incorrect passcode", message:
                    "Sorry, your passcode was incorrect. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }

    }

}

