//
//  UITableViewGreyBorderRadius.swift
//  SayaraDz
//
//  Created by Mac on 3/7/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit

class UITableViewGreyBorderRadius: UITableView {

    override func awakeFromNib() {
        self.alpha = 0
    }
    
    func Open() {
        UIView.animate(withDuration: 0, animations: { () -> Void in
            self.frame.size.height = 200
            self.alpha = 1
        })
    }
    
    func Close() {
        self.frame.size.height = 0
        self.alpha = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
    }

}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
