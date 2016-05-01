//
//  SignUpVC.swift
//  Footprint
//
//  Created by Atir Petkar on 4/29/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var emailField: MaterialTextField!
    
    
    
    @IBOutlet weak var passwordField: MaterialTextField!
    
    
    
    @IBOutlet weak var reenterPasswordField: MaterialTextField!
    
    @IBOutlet weak var bioField: MaterialTextField!
    
    
    
    @IBAction func createAccount(sender: AnyObject) {
        
        //make sure all the details are filled in by user on sign up screen
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "", let rePwd = reenterPasswordField.text where rePwd != "", let bio = bioField.text where bio != "" {
            
            //make sure password and re-enter password are same
            if pwd == rePwd {
            
            //create user in Firebase
                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
                            
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
                            } else {
                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
                                print("new account created")
                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
                                self.performSegueWithIdentifier(SEGUE_SIGNUP, sender: nil)
                            }
                            
                        })//closure ends
//                    } else {
//                        self.showErrorAlert("Could not login", msg: "Please check your username or password")
//                    }
//                    
            }
            else {
                showErrorAlert("Password do not match", msg: "Make sure you enter the same password in both password and re-enter password fields")
            }
            
            
            
        } else {
           // showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
             showErrorAlert("Details required", msg: "You must enter all the details to create a Footprint account")

        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tap gesture recognizer to dismiss keyboard when tapped
        let hideTap = UITapGestureRecognizer(target: self, action: "hideKeyBoardTap:")
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        

    }
    
    
    //tap gesture recognizer to hide keyboard if tapped
    func hideKeyBoardTap(recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    

}
