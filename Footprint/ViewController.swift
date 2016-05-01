//
//  ViewController.swift
//  Footprint
//
//  Created by Atir Petkar on 4/28/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailField: MaterialTextField!
    
    
    @IBOutlet weak var passwordField: MaterialTextField!
    
    
    @IBAction func attemptLogin(sender: AnyObject) {
        
        if let email = emailField.text where email != "", let pwd = passwordField.text where pwd != "" {
            
            DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: { error, authData in
                
                if error != nil {
                    
//                    print(error)
//                    
//                    if error.code == STATUS_ACCOUNT_NONEXIST {
//                        //create the account
//                        DataService.ds.REF_BASE.createUser(email, password: pwd, withValueCompletionBlock: { error, result in
//                            
//                            if error != nil {
//                                self.showErrorAlert("Could not create account", msg: "Problem creating account. Try something else")
//                            } else {
//                                NSUserDefaults.standardUserDefaults().setValue(result[KEY_UID], forKey: KEY_UID)
//                                print("new account created \(result[KEY_UID])")
//                                DataService.ds.REF_BASE.authUser(email, password: pwd, withCompletionBlock: nil)
//                                self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
//                            }
//                            
//                        })//closure ends
//                    } else
//                    {
                        self.showErrorAlert("Could not login", msg: "Please check your username or password")
                   // }
                    
                } else {
                    self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
                }//account exist and go to the next controller
                
            })
            
            
        } else {
            showErrorAlert("Email and Password Required", msg: "You must enter an email and a password")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // print("ns user defaults \(NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID)!)")
        
        
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        print("ns user defaults \(NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID))")
        
        
        if NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) != nil {
            self.performSegueWithIdentifier(SEGUE_LOGGED_IN, sender: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }



}

