//
//  DataService.swift
//  Footprint
//
//  Created by Atir Petkar on 4/29/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//



//making a singleton class to access Firebase


import Foundation
import Firebase



let URL_BASE = "https://iosfootprint-dev.firebaseio.com"

class DataService {
    
    
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
    
    //added for test
    private var _REF_POSTS2 = Firebase(url: "\(URL_BASE)/posts2")
    
    private var _REF_USERS = Firebase(url: "\(URL_BASE)/users")
    
    var REF_BASE: Firebase {
        return _REF_BASE
    }
    
    var REF_POSTS: Firebase {
        return _REF_POSTS
    }
    
    var REF_USERS: Firebase {
        return _REF_USERS
    }
    
    //added..not reqd
    var REF_POSTS2: Firebase {
        return _REF_POSTS2
    }
    
    //so we can have access to anything related to user, in all the view controllers
    var REF_USER_CURRENT: Firebase {
        let uid = NSUserDefaults.standardUserDefaults().valueForKey(KEY_UID) as! String
        let user = Firebase(url: "\(URL_BASE)").childByAppendingPath("users").childByAppendingPath(uid)
        return user!
    }
    
    
    //still to be seen use of access to post id
    var REF_POST_FOR_USER : [String] = []
    
    func createFirebaseUser(uid: String, user: Dictionary<String, String>){
        REF_USERS.childByAppendingPath(uid).setValue(user)
    }
    
    
    
}