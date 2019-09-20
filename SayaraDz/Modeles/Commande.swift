//
//  Commande.swift
//  SayaraDz
//
//  Created by Mac on 7/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
class ClientTokenCommande: Decodable {
    let clientToken: String
    let success: Bool
    init(clientToken: String, success: Bool) {
        self.clientToken = clientToken
        self.success = success
    }
}

class Commande: Decodable {
    let idCommande: Int
    let Montant: Int
    let automobiliste: AutomobilisteC
    let vehicule: VehiculeC
    let Fabricant: Int
    let Date: String
    let Etat: Int
    let Reservation: Int?
    
    init(idCommande: Int, Montant: Int, automobiliste: AutomobilisteC, vehicule: VehiculeC, Fabricant: Int, Date: String, Etat: Int, Reservation: Int) {
        self.idCommande = idCommande
        self.Montant = Montant
        self.automobiliste = automobiliste
        self.vehicule = vehicule
        self.Fabricant = Fabricant
        self.Date = Date
        self.Etat = Etat
        self.Reservation = Reservation
    }
    
    class AutomobilisteC: Decodable {
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
    
    class VehiculeC: Decodable {
        let NumChassis : Int
        let Concessionaire : String
        let NomMarque : String
        let NomModele : String
        let NomVersion : String
        init(NumChassis : Int, Concessionaire : String, NomMarque : String, NomModele : String, NomVersion: String) {
            self.NumChassis = NumChassis
            self.Concessionaire = Concessionaire
            self.NomMarque = NomMarque
            self.NomModele = NomModele
            self.NomVersion = NomVersion
        }
    }
    

}



