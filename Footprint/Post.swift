//
//  Post.swift
//  Footprint
//
//  Created by Atir Petkar on 5/1/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _postDescription: String?
    private var _imageUrl: String?
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    private var _postRef: Firebase!
    
    var postDescription: String? {
        return _postDescription
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    var likes: Int
    {
        return _likes
    }
    
    var username: String {
        return _username
    }
    
    var postKey: String {
        return _postKey
    }
    
    
    init(description: String, imageUrl: String?, username: String){
        
        self._postDescription = description
        self._imageUrl = imageUrl
        self._username = username
        
    }
    
    
    init(postKey: String, dictionary:Dictionary<String, AnyObject>){
        self._postKey = postKey
       // print("postKey from init \(postKey)")
        
        if let likes = dictionary["likes"] as? Int {
            self._likes = likes
        }
        
        if let imgUrl = dictionary["image"] as? String{
            self._imageUrl = imgUrl
          //  print("image from init \(imgUrl)")
        }
        if let desc = dictionary["description"] as? String {
            self._postDescription = desc
           // print("dexcription from init \(desc)")
        }
        
        self._postRef = DataService.ds.REF_POSTS.childByAppendingPath(self._postKey)
        
    }
    
    
    
    //if addLike is true, add the likes and vice versa for the user
    func adjustLikes(addLike: Bool){
        
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        //grabbing the likes key in the specific post
        _postRef.childByAppendingPath("likes").setValue(_likes)
    }
    
    
    
    
    
    
}