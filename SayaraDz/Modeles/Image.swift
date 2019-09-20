//
//  Image.swift
//  SayaraDz
//
//  Created by Mac on 6/21/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation

class Image: Decodable {
    let CheminImage: String
    init(CheminImage: String) {
        self.CheminImage = CheminImage
    }
}
