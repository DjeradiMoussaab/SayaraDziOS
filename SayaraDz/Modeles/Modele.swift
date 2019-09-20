//
//  Modele.swift
//  SayaraDz
//
//  Created by Mac on 4/11/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class Modele: Decodable {
    let CodeModele: Int
    let CodeMarque: Int
    let NomModele: String
    let versions: Array<VersionM>
    let options: Array<Option>
    let couleurs: Array<Couleur>
    let images: Array<Image>
    
    init(CodeModele: Int, CodeMarque: Int, NomModele: String, Versions: Array<VersionM>, Options: Array<Option>, Couleurs: Array<Couleur>, Images: Array<Image>) {
        self.CodeModele = CodeModele
        self.CodeMarque = CodeMarque
        self.NomModele = NomModele
        self.versions = Versions
        self.options = Options
        self.couleurs = Couleurs
        self.images = Images
    }
    
    class VersionM: Decodable {
        let CodeVersion: Int
        let CodeModele: Int
        let NomVersion: String
        
        init(CodeVersion: Int, CodeModele: Int, NomVersion: String) {
            self.CodeVersion = CodeVersion
            self.CodeModele = CodeModele
            self.NomVersion = NomVersion
        }
    }
}

