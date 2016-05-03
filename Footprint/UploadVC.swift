//
//  UploadVC.swift
//  Footprint
//
//  Created by Atir Petkar on 5/2/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var postField: MaterialTextField!
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var imageSelectorImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    
   

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        profilePic.layer.cornerRadius = profilePic.frame.size.width/2
        profilePic.clipsToBounds = true

        
        
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
    
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        imageSelectorImage.image = image

    }
    

    @IBAction func selectImage(sender: UITapGestureRecognizer) {

        
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
        imageSelectorImage.clipsToBounds = true
    }
    
   
    
    
    
    @IBAction func makePost(sender: MaterialButton) {
        
        
        
        showPostAlert("Shared", msg: "Your footprint is shared with your friends")
    }
    
    
    
    
    func showPostAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
