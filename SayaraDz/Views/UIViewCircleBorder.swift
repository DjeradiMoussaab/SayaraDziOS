//
//  UIViewCircleBorder.swift
//  SayaraDz
//
//  Created by Mac on 7/4/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class UIViewCircleBorder: UIView {
    override func awakeFromNib() {
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
        self.layer.cornerRadius = self.frame.height/2
    }
}

class UIButtonCircleBorder: UIButton {
    override func awakeFromNib() {
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
        self.layer.cornerRadius = self.frame.height/2
    }
}

class UITextFieldCircleBorder: UITextField {
    
    override func awakeFromNib() {
        self.frame.size.height = 40.0
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
        self.layer.cornerRadius = self.frame.height/2
    }
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
