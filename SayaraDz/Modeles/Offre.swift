//
//  Offre.swift
//  SayaraDz
//
//  Created by Mac on 8/26/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation

class Offre : Decodable {
    let idOffre: Int
    let idAnnonce: Int
    let Montant : String
    let idAutomobiliste : String
    let Date: String
    let Etat: Int
    let automobiliste: Automobiliste
    
    init(idOffre: Int, idAnnonce: Int, Montant : String, idAutomobiliste : String, Date: String, Etat: Int, automobiliste: Automobiliste) {
        self.idOffre = idOffre
        self.idAnnonce = idAnnonce
        self.Montant = Montant
        self.idAutomobiliste = idAutomobiliste
        self.Date = Date
        self.Etat = Etat
        self.automobiliste = automobiliste
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
    
    
}
