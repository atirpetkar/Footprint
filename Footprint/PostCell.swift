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
    
    var post: Post!
    
    //we need to store the firebase request in order to cancel if the image already exist in the cache
    var request: Request?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func drawRect(rect: CGRect) {
        
        //to make it circular
        profileImg.layer.cornerRadius = profileImg.frame.size.width/2
        
        profileImg.clipsToBounds = true
        postImg.clipsToBounds = true

    }
    
    

    func configureCell(post: Post, img: UIImage?) {
        
        self.post = post
        
        self.descriptionText.text = post.postDescription
        self.likesLbl.text = "\(post.likes)"
        
       // if image is in cache
        if img != nil {
       self.postImg.image = img
        }
        //if image is not in cache, we got to make request
        else {
            request = Alamofire.request(.GET, post.imageUrl).validate(contentType: ["image/*"]).response(completionHandler:
                { request, response, data, err in
                    if err == nil {
                        let img = UIImage(data: data!)!
                        self.postImg.image = img
                        FeedTableVC.imageCache.setObject(img, forKey: self.post.imageUrl)
                    }
            })
        }
    }
    
    
    
    

}
