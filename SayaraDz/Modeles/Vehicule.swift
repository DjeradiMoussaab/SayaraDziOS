//
//  Vehicule.swift
//  SayaraDz
//
//  Created by Mac on 7/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
class VehiculeDisponobility: Decodable {
    let NumChassis: Int
    let Options: Array<OptionVehicule>
    let Montant: Int
    init(NumChassis: Int, Options: Array<OptionVehicule>, Montant: Int) {
        self.NumChassis = NumChassis
        self.Options = Options
        self.Montant = Montant
    }
    

}

class OptionVehicule: Decodable {
    let CodeOption: Int
    let NomOption: String
    let rel_vehic_opt: EmptyType
    init(CodeOption: Int, NomOption: String, rel_vehic_opt: EmptyType) {
        self.CodeOption = CodeOption
        self.NomOption = NomOption
        self.rel_vehic_opt = rel_vehic_opt
    }
}

class EmptyType: Decodable {
    
}
