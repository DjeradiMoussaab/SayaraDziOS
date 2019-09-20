//
//  UIViewCircle.swift
//  SayaraDz
//
//  Created by Mac on 6/16/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class UIViewCircle: UIView {

    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor.gray.cgColor

    }
    
    func changeToSelected() {
        self.layer.borderWidth = CGFloat(3)
        self.layer.borderColor = UIColor.lightGray.cgColor


    }
    func changeToUnselected() {
        self.layer.borderWidth = CGFloat(1)
        self.layer.borderColor = UIColor.gray.cgColor

    }
    

}

class UIImageViewCircle: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.borderWidth = CGFloat(2)
        self.layer.borderColor = UIColor.gray.cgColor
        
    }
    
}
