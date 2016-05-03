//
//  Post.swift
//  Footprint
//
//  Created by Atir Petkar on 5/1/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import Foundation

class Post {
    private var _postDescription: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _username: String!
    private var _postKey: String!
    
    var postDescription: String {
        return _postDescription
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var username: String {
        return _username
    }
    
    
    init(description: String, imageUrl: String, username: String){
        
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
    }
    
    
    
    
    
    
    
    
    
    
    
}