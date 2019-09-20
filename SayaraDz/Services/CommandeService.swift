//
//  CommandeService.swift
//  SayaraDz
//
//  Created by Mac on 7/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
class CommandeService {
    static let sharedInstance = CommandeService()
    
    func getToken(onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "vehicules/reservations/demande"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil){
                onFailure(error!)
            } else {
                onSuccess(data!)
            }
        })
        task.resume()
    }
    
    func postNonce(IdCommande: Int, Montant: String, Nonce: String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "vehicules/reservations/paiement"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["idCommande": "\(IdCommande)", "payment_method_nonce": "\(Nonce)", "Montant": "\(Montant)"]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        let strs = String(decoding: request.httpBody!, as: UTF8.self)
        print(strs)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil){
                onFailure(error!)
            } else {
                onSuccess(data!)
            }
        })
        task.resume()
    }
    
    func createCommande(Token: String, idAutomobiliste: String, NumChassis: Int, Montant: Int, Fabricant: String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "vehicules/commandes"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
       // request.setValue("Bearer F \(Token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["idAutomobiliste": "\(idAutomobiliste)", "NumChassis": "\(NumChassis)", "Montant": "\(Montant)", "Fabricant" : "\(Fabricant)"]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }


        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil){
                onFailure(error!)
            } else {
                onSuccess(data!)
            }
        })
        task.resume()
    }
    
}
