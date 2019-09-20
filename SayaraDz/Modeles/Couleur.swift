//
//  Couleur.swift
//  SayaraDz
//
//  Created by Mac on 6/21/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
class Couleur: Decodable {
    let CodeCouleur: Int
    let NomCouleur: String
    let CodeHexa: String
    init(CodeCouleur: Int, NomCouleur: String, CodeHexa: String) {
        self.CodeCouleur = CodeCouleur
        self.NomCouleur = NomCouleur
        self.CodeHexa = CodeHexa
    }
}
