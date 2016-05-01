//
//  DataService.swift
//  Footprint
//
//  Created by Atir Petkar on 4/29/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import Foundation
import Firebase



let URL_BASE = "https://iosfootprint.firebaseio.com"

class DataService {
    
    
    
    static let ds = DataService()
    
    private var _REF_BASE = Firebase(url: "\(URL_BASE)")
    private var _REF_POSTS = Firebase(url: "\(URL_BASE)/posts")
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
    
    
    
    
    
    
}