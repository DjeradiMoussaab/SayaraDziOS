//
//  Option.swift
//  SayaraDz
//
//  Created by Mac on 6/21/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
class Option: Decodable {
    let CodeOption: Int
    let NomOption: String
    init(CodeOption: Int, NomOption: String) {
        self.CodeOption = CodeOption
        self.NomOption = NomOption
    }
}
