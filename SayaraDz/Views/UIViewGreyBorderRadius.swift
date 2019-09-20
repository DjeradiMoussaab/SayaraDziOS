//
//  UIViewGreyBorderRadius.swift
//  SayaraDz
//
//  Created by Mac on 3/7/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class UIViewGreyBorderRadius: UIView {

    var chosen: Bool = false
    override func awakeFromNib() {
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
        self.layer.cornerRadius = 10.0
    }
    
    func Open() {
        UIView.animate(withDuration: 0, animations: { () -> Void in
            self.frame.size.height = 300
        })
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
    }
    
    func Close() {
        if ( chosen ) {
            self.frame.size.height = 100
        } else {
            self.frame.size.height = 80
        }
        self.layer.shadowOpacity = 0
    }
    
    func setChosenTrue() {
        self.chosen = true
    }
    
    func setChosenFalse() {
        self.chosen = false
    }
    
}

class UIViewGreyBorderRadiusShadow: UIView {
    override func awakeFromNib() {
        self.layer.borderWidth = CGFloat(0.4)
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
    }
}

class UIViewDarkBorder: UIView {
    override func awakeFromNib() {
        self.layer.borderWidth = CGFloat(0.4)
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 10.0
    }
}


