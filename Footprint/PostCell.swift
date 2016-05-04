//
//  PostCell.swift
//  Footprint
//
//  Created by Atir Petkar on 5/1/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

class PostCell: UITableViewCell {
    
    

    @IBOutlet weak var profileImg: UIImageView!
    
    //mp has below thing as showcaseImg
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    var post: Post!
    
    //we need to store the firebase request in order to cancel if the image already exist in the cache
    var request: Request!
    
    
    var likeRef: Firebase!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add tap gesture recognizer for our like image
        let tap = UITapGestureRecognizer(target: self, action: "likeTapped:")
        tap.numberOfTapsRequired = 1
        likeImage.addGestureRecognizer(tap)
        likeImage.userInteractionEnabled = true
    }
    
    func likeTapped(sender: UITapGestureRecognizer){
        
        
        likeRef.observeSingleEventOfType(.Value, withBlock:  { snapshot in
            
            //if there is no like by user i.e we get NSNull, show empty heart
            if let doesNotExist = snapshot.value as? NSNull {
                
                //this means we have not liked this specific  post, so after taping we should like it and we should have a full heart
                self.likeImage.image = UIImage(named: "heart-full")
                
                //pass true to adjust likes function of post to add 1 like
                self.post.adjustLikes(true)
                
                //add it to the user list of likes
                self.likeRef.setValue(true)

                
                
            } else{
                self.likeImage.image = UIImage(named: "heart-empty")
                //pass true to adjust likes function of post to add 1 like
                self.post.adjustLikes(false)
                self.likeRef.removeValue()

                
            }
            
            
        })
        
        
    }
    
    
    override func drawRect(rect: CGRect) {
        
        //to make it circular
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        
        profileImg.clipsToBounds = true
        postImg.clipsToBounds = true

    }
    
    

    func configureCell(post: Post, img: UIImage?) {
        
        self.post = post
        
        likeRef = DataService.ds.REF_USER_CURRENT.childByAppendingPath("likes").childByAppendingPath(post.postKey)
        
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
       // if image is in cache
        if img != nil {
       self.postImg.image = img
        }
        //if image is not in cache, we got to make request
        else {
            request = Alamofire.request(.GET, post.imageUrl!).validate(contentType: ["image/*"]).response(completionHandler:
                { request, response, data, err in
                    
                    if err == nil {
                        let img = UIImage(data: data!)!
                        self.postImg.image = img
                        FeedTableVC.imageCache.setObject(img, forKey: self.post.imageUrl!)
                    }
            })
        }
        
        
        
        //in firebase if we get no value, we get NSNull and not nil or Null
        
        likeRef.observeSingleEventOfType(.Value, withBlock:  { snapshot in
            
            //if there is no like by user i.e we get NSNull, show empty heart
            if let doesNotExist = snapshot.value as? NSNull {
        
                //this means we have not liked this specific  post, show heart-empty
        
                self.likeImage.image = UIImage(named: "heart-empty")
                
                
            } else{
                self.likeImage.image = UIImage(named: "heart-full")

            }
            
        
        })
        
        
    }
    
    
    
    

}
