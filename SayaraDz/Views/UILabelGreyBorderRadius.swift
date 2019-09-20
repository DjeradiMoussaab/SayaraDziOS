//
//  UILabelGreyBorderRadius.swift
//  SayaraDz
//
//  Created by Mac on 4/7/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class UILabelGreyBorderRadius : UILabel {
    
    override func awakeFromNib() {
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor(red:0.60, green:0.46, blue:0.64, alpha:1.0).cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.text = "Seat"
        self.frame.size.width = CGFloat((self.text?.count)!*10) + 50
    }
    
}
