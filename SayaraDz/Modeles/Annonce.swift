//
//  Annonce.swift
//  SayaraDz
//
//  Created by Mac on 7/5/19.
//  Copyright © 2019 mossab. All rights reserved.
//

class Annonce : Decodable {
    let idAnnonce: Int
    let Prix: String
    let automobiliste : Automobiliste
    let version : VersionA
    let Couleur: String
    let Km: String
    let Carburant: String
    let Annee: Int
    let Description: String
    let NombreOffres : Int
    let images: Array<Image>
    
    init(idAnnonce: Int, Prix: String, automobiliste : Automobiliste, version : VersionA, Couleur: String, Km: String, Carburant: String, Annee: Int, Description: String, NombreOffres : Int, images: Array<Image>) {
        self.idAnnonce = idAnnonce
        self.Prix = Prix
        self.automobiliste = automobiliste
        self.version = version
        self.Couleur = Couleur
        self.Km = Km
        self.Carburant = Carburant
        self.Annee = Annee
        self.Description = Description
        self.NombreOffres = NombreOffres
        self.images = images
    }
    
}

class Automobiliste: Decodable {
    let idAutomobiliste : String
    let NumTel : String?
    let Nom : String
    let Prenom : String
    init(idAutomobiliste : String, NumTel : String, Nom : String, Prenom : String) {
        self.idAutomobiliste = idAutomobiliste
        self.NumTel = NumTel
        self.Nom = Nom
        self.Prenom = Prenom
    }
}

class VersionA: Decodable {
    let CodeVersion : Int
    let NomVersion : String
    let NomModele : String
    let NomMarque : String
    init(CodeVersion : Int, NomVersion : String, NomModele : String, NomMarque : String) {
        self.CodeVersion = CodeVersion
        self.NomVersion = NomVersion
        self.NomModele = NomModele
        self.NomMarque = NomMarque
    }
}

class Annonce3n : Decodable {
    let idAnnonce: Int
    let Prix: String
    let automobiliste : Automobiliste
    let version : VersionA
    let Couleur: String
    let Km: String
    let Carburant: String
    let Annnee: Int
    let Description: String
    let NombreOffres : Int
    let images: Array<Image>
    
    init(idAnnonce: Int, Prix: String, automobiliste : Automobiliste, version : VersionA, Couleur: String, Km: String, Carburant: String, Annnee: Int, Description: String, NombreOffres : Int, images: Array<Image>) {
        self.idAnnonce = idAnnonce
        self.Prix = Prix
        self.automobiliste = automobiliste
        self.version = version
        self.Couleur = Couleur
        self.Km = Km
        self.Carburant = Carburant
        self.Annnee = Annnee
        self.Description = Description
        self.NombreOffres = NombreOffres
        self.images = images
    }
    
}
