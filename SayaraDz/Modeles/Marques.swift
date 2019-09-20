//
//  Marques.swift
//  SayaraDz
//
//  Created by Mac on 3/8/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class Marque: Decodable {
    let CodeMarque: Int
    let NomMarque: String
    let images: Array<Image>
    
    init(CodeMarque: Int, NomMarque: String, images: Array<Image>) {
        self.CodeMarque = CodeMarque
        self.NomMarque = NomMarque
        self.images = images
    }
}

