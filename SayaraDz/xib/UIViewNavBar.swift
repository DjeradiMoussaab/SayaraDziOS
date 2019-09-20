//
//  UIViewNavBar.swift
//  SayaraDz
//
//  Created by Mac on 7/1/19.
//  Copyright © 2019 mossab. All rights reserved.
//


import UIKit

class UIViewNavBar : UIView {
    let kCONTENT_XIB_NAME = "UIViewNavBar"
    @IBOutlet var UIViewNavBar: UIViewNavBar!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    
    override func awakeFromNib() {
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        UIViewNavBar.fixInView(self)
    }
    
}

