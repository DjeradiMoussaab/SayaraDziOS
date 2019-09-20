//
//  LigneTarif.swift
//  SayaraDz
//
//  Created by Mac on 6/21/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
class LigneTarif: Decodable {
    let idLigneTarif: Int
    let `Type`: Int
    let Code: Int
    let DateDebut: String
    let DateFin: String
    let Prix: Int

    init(idLigneTarif: Int, `Type`: Int, Code: Int,DateDebut: String, DateFin: String, Prix: Int) {
        self.idLigneTarif = idLigneTarif
        self.`Type` = `Type`
        self.Code = Code
        self.DateDebut = DateDebut
        self.DateFin = DateFin
        self.Prix = Prix
    }
}
