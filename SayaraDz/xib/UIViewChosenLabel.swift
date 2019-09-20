//
//  UILabelChosen.swift
//  SayaraDz
//
//  Created by Mac on 4/8/19.
//  Copyright © 2019 mossab. All rights reserved.
//


import UIKit

class UIViewChosenLabel : UIView {
    let kCONTENT_XIB_NAME = "UIViewChosenLabel"
    @IBOutlet var ContentView: UIViewChosenLabel!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Close: UIButton!
    override func awakeFromNib() {
        self.updateFrame()
        self.Close.isHidden = true
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
        ContentView.fixInView(self)
    }
    
    func show() {
        self.isHidden = false
    }
    @IBAction func close(_ sender: Any) {
        //self.isHidden = true
    }
    func close() {
        self.isHidden = true
    }
    
    func updateFrame() {
        self.frame.size.width = CGFloat((Label.text?.count)!*10 + 50)
    }
}

extension UIView
{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}
