//
//  LoginService.swift
//  SayaraDz
//
//  Created by Mac on 7/1/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation


class LoginService {
    static let sharedInstance = LoginService()
    func createAutomobiliste(token: String, idAutomobiliste: String, Nom: String, Prenom: String, NumTel: String,onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "auth/automob"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        print(token)
        request.setValue("Bearer F \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = ["idAutomobiliste": "\(idAutomobiliste)", "Nom": "\(Nom)", "Prenom": "\(Prenom)", "NumTel": "\(NumTel)"]
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
                print("faaailed")
                print(error!)
                print(response)
            } else {
                onSuccess(data!)
                print("succeded")
                let str = String(decoding: data!, as: UTF8.self)
                print(str)
            }
        })
        task.resume()
    }
}
