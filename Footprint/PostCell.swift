//
//  PostCell.swift
//  Footprint
//
//  Created by Atir Petkar on 5/1/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    

    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var postImg: UIImageView!
    
    
    
    
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
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
