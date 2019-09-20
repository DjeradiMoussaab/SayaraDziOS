//
//  Version.swift
//  SayaraDz
//
//  Created by Mac on 4/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class Version: Decodable {
    let CodeVersion: Int
    let CodeModele: Int
    let NomVersion: String
    let options: Array<OptionVersion>
    let couleurs: Array<CouleurV>
    let modele: ModeleV
    let lignetarif: LigneTarif
    
    init(CodeVersion: Int, CodeModele: Int, NomVersion: String, Options: Array<OptionVersion>, Couleurs: Array<CouleurV>,Modele: ModeleV,LigneTarif: LigneTarif) {
        self.CodeVersion = CodeVersion
        self.CodeModele = CodeModele
        self.NomVersion = NomVersion
        self.modele = Modele
        self.options = Options
        self.couleurs = Couleurs
        self.lignetarif = LigneTarif
    }
}

class VersionSuivie: Decodable {
    let CodeVersion: Int
    let CodeModele: Int
    let NomVersion: String
    let options: Array<OptionVersion>
    let couleurs: Array<CouleurV>
    let modele: ModeleV
    let lignetarif: LigneTarif
    let suivie: Bool
    
    init(CodeVersion: Int, CodeModele: Int, NomVersion: String, Options: Array<OptionVersion>, Couleurs: Array<CouleurV>,Modele: ModeleV,LigneTarif: LigneTarif, suivie: Bool) {
        self.CodeVersion = CodeVersion
        self.CodeModele = CodeModele
        self.NomVersion = NomVersion
        self.modele = Modele
        self.options = Options
        self.couleurs = Couleurs
        self.lignetarif = LigneTarif
        self.suivie = suivie
    }
}


class ModeleV: Decodable {
    let NomModele: String
    let marque : MarqueV
    init(NomModele: String, marque: MarqueV) {
        self.NomModele = NomModele
        self.marque = marque
    }
    class MarqueV: Decodable {
        let NomMarque: String
        
        init(NomMarque: String) {
            self.NomMarque = NomMarque
        }
    }
}
class CouleurV: Decodable {
    let CodeCouleur: Int
    let NomCouleur: String
    let CodeHexa: String
    let CheminImage: String?
    init(CodeCouleur: Int, NomCouleur: String, CodeHexa: String, CheminImage: String) {
        self.CodeCouleur = CodeCouleur
        self.NomCouleur = NomCouleur
        self.CodeHexa = CodeHexa
        self.CheminImage = CheminImage
    }
}

class OptionVersion: Decodable {
    let CodeOption: Int
    let NomOption: String
    let rel_ver_opt: EmptyType
    init(CodeOption: Int, NomOption: String, rel_ver_opt: EmptyType) {
        self.CodeOption = CodeOption
        self.NomOption = NomOption
        self.rel_ver_opt = rel_ver_opt
    }
}
