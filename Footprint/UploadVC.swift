//
//  UploadVC.swift
//  Footprint
//
//  Created by Atir Petkar on 5/2/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var postField: MaterialTextField!
    
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var imageSelectorImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    //boolean variable to check if user has actually picked an image to post or not, because by default it has footprint image
   var imageSelected = false

    
    
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
        imageSelected = true

    }
    

    @IBAction func selectImage(sender: UITapGestureRecognizer) {

        
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        imageSelectorImage.clipsToBounds = true
    }
    
   
    
    
    
    @IBAction func makePost(sender: MaterialButton) {
        
        if let txt = postField.text where txt != "" {
            if let img = imageSelectorImage.image where imageSelected == true{
                
                let urlStr = "https://post.imageshack.us/upload_api.php"
                let url = NSURL(string: urlStr)!
                
                
                //compress the image 
                let imgData = UIImageJPEGRepresentation(img, 0.2)!
                
                let keyData = "12DJKPSU5fc3afbd01b1630cc718cae3043220f3".dataUsingEncoding(NSUTF8StringEncoding)!
                let keyJSON = "json".dataUsingEncoding(NSUTF8StringEncoding)!
                
               Alamofire.upload(.POST, url, multipartFormData: { multipartFormData in
                multipartFormData.appendBodyPart(data: imgData, name: "fileupload", fileName: "image", mimeType: "image/jpg")
                multipartFormData.appendBodyPart(data: keyData, name: "key")
                multipartFormData.appendBodyPart(data: keyJSON, name: "format")
                
               }){ //when upload is done
                encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                  //  upload.responseJSON(completionHandler: <#T##Response<AnyObject, NSError> -> Void#>)
                    upload.responseJSON(completionHandler: { response in
                        
                        if let info = response.result.value as? Dictionary<String, AnyObject> {
                            if let links = info["links"] as? Dictionary<String, AnyObject>{
                                if let imgLink = links["image_link"] as? String {
                                        print("LINK: \(imgLink)")
                                    self.postToFirebase(imgLink)
                                    
                                }
                            }
                        }
                    })
                    
                case .Failure(let error):
                    print(error)
                }
               }
                
                showPostAlert("Shared", msg: "Your footprint is shared with your friends")

              }
            else {
                showPostAlert("Image needed", msg: "Footprint needs an image to share")
            }
        } else {
            showPostAlert("Post Description needed", msg: "Your footprint needs a description")

        }
        
    }
    
    
    func postToFirebase(imgUrl: String){
        
        var post: Dictionary<String, AnyObject> = [
            "description": postField.text!,
            "likes": 0,
            "image": imgUrl
        ]
        
    
           let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        
        //after posting, make sure text and image disappear from the screen
        self.postField.text = ""
        imageSelectorImage.image = UIImage(named: "footprint-1")
        //make the imageSelected boolean back to false
        imageSelected = false
        
    
        
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
