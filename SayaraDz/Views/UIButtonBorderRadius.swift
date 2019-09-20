//
//  UIButtonBorderRadius.swift
//  SayaraDz
//
//  Created by Mac on 4/13/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class UIButtonBorderRadius : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
}


class UIButtonBorderRadiusPurple : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor(red:0.30, green:0.15, blue:0.47, alpha:1.0).cgColor
    }
}

class UIButtonBorderRadiusPurpleLight : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor(red:0.30, green:0.15, blue:0.47, alpha:1.0).cgColor
    }
}


class UIButtonBorderRadiusGrey : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
}

class UIButtonShadow : UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
    }
}
