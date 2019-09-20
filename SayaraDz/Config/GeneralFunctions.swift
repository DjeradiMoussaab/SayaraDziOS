//
//  GeneralFunctions.swift
//  SayaraDz
//
//  Created by Mac on 7/5/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import UIKit


func numberFromatterToCurrency(price: Int) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale(identifier: "en_DZ")
    formatter.numberStyle = .currency
    if let formattedTipAmount = formatter.string(from: price as NSNumber) {
        return formattedTipAmount
    }
    return "\(price)"
}
