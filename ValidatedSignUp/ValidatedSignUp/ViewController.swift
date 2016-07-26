//
//  ViewController.swift
//  ValidatedSignUp
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var textFieldArray = [UITextField!]()
    
    var firstNameAlert: UIAlertController!
    var lastNameAlert: UIAlertController!
    var userNameAlert: UIAlertController!
    var emailAlert: UIAlertController!
    var passwordAlert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTextFieldDelegate()
        
        textFieldArray = [firstNameField, lastNameField, emailField, usernameField, passwordField]
        for textField in textFieldArray {
            textField.enabled = false
        }
        firstNameField.enabled = true
        
        submitButton.enabled = false
        
        configureAlertMessages()
        addAlertActions()
    }
    
    // MARK - Text Field Delegate Functions
    
    func setTextFieldDelegate() {
        firstNameField.delegate = self
        lastNameField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        emailField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if !validTextField(textField){
            displayAlert(textField)
        } else {
            textField.enabled = false
            textField.resignFirstResponder()
            textFieldArray.removeFirst()
            
            if let nextField = textFieldArray.first {
                nextField.enabled = true
                nextField.becomeFirstResponder()
            }
            
            if textFieldArray.isEmpty {
                submitButton.enabled = true
            }
        }
        return false
    }
    
    // MARK - Text Field Validation Functions
    
    func validTextField(textField: UITextField) -> Bool {
        switch textField.placeholder! {
        case "First Name", "Last Name", "User Name":
            return validName(textField)
        case "Email Address":
            return validEmail()
        case "Password":
            return validPassword()
        default:
            return false
        }
    }
    
    // Validation is the same for first name, last name and username:
    func validName(nameField: UITextField!) -> Bool {
        let invalid = NSCharacterSet.letterCharacterSet().invertedSet
        
        if let name = nameField.text {
            return name.characters.count > 0 && name.rangeOfCharacterFromSet(invalid) == nil
        }
        return false
    }
    
    func validEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(emailField.text)
    }
    
    func validPassword() -> Bool {
        return passwordField.text?.characters.count > 6
    }
    
    // MARK - Alert Controllers
    
    func configureAlertMessages() {
        firstNameAlert = UIAlertController(title: "Default Style", message: "Your name must have at least one character and cannot contain any digits.", preferredStyle: .Alert)
        
        lastNameAlert = UIAlertController(title: "Default Style", message: "Your last name must have at least one character and cannot contain any digits.", preferredStyle: .Alert)
        
        userNameAlert = UIAlertController(title: "Default Style", message: "Your username must have at least one character and cannot contain any digits.", preferredStyle: .Alert)
    
        emailAlert = UIAlertController(title: "Default Style", message: "Please provide a valid email address.", preferredStyle: .Alert)

        passwordAlert = UIAlertController(title: "Default Style", message: "Your password must contain more than six characters.", preferredStyle: .Alert)
    }

    func configureAlertActions(controller: UIAlertController, textField: UITextField) {
        let clearAction = UIAlertAction(title: "Clear", style: .Cancel) { (action) in
            // Clear the text from the text field:
            textField.text = ""
        }
        controller.addAction(clearAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // Dismiss the alert:
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
        controller.addAction(OKAction)
    }
    
    func addAlertActions() {
        configureAlertActions(firstNameAlert, textField: firstNameField)
        configureAlertActions(lastNameAlert, textField: lastNameField)
        configureAlertActions(userNameAlert, textField: usernameField)
        configureAlertActions(emailAlert, textField: emailField)
        configureAlertActions(passwordAlert, textField: passwordField)
    }
    
    func displayAlert(textField: UITextField) {
        switch textField.placeholder! {
        case "First Name":
            self.presentViewController(firstNameAlert, animated: true, completion: nil)
        case "Last Name":
            self.presentViewController(lastNameAlert, animated: true, completion: nil)
        case "User Name":
            self.presentViewController(userNameAlert, animated: true, completion: nil)
        case "Email Address":
            self.presentViewController(emailAlert, animated: true, completion: nil)
        case "Password":
            self.presentViewController(passwordAlert, animated: true, completion: nil)
        default:
            print("There are no other text field placeholder values.")
        }
    }

    @IBAction func submitTapped(sender: AnyObject) {
    }
    
}

