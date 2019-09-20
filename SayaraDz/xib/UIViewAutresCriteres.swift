//
//  UIViewAutresCriteres.swift
//  SayaraDz
//
//  Created by Mac on 7/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit
import SwiftRangeSlider


class UIViewAutresCriteres : UIView {
    let kCONTENT_XIB_NAME = "UIViewAutresCriteres"
    @IBOutlet var UIViewAutresCriteres: UIViewAutresCriteres!
    @IBOutlet weak var energieCollectionView: UICollectionView!
    @IBOutlet weak var minAnnee: UITextField!
    @IBOutlet weak var maxAnnee: UITextField!
    @IBOutlet weak var priceSlider: RangeSlider!
    @IBOutlet weak var KmSlider: RangeSlider!
    
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
        UIViewAutresCriteres.fixInView(self)
    }
    
}
