//
//  VehiculeService.swift
//  SayaraDz
//
//  Created by Mac on 7/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation

class VehiculeService {
    static let sharedInstance = VehiculeService()
    
    func getDisponibility(codeVersion : String, codeCouleur: String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "vehicules/stock/disponible"
        print(url)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["codeVersion": "\(codeVersion)", "codeCouleur": "\(codeCouleur)"]
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

}
