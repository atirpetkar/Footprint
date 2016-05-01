//
//  MaterialButton.swift
//  Footprint
//
//  Created by Atir Petkar on 4/28/16.
//  Copyright © 2016 Atir Petkar. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
        
    }

}
