//
//  AnnonceService.swift
//  SayaraDz
//
//  Created by Mac on 7/5/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
import SwiftyJSON

class AnnonceService {
    static let sharedInstance = AnnonceService()
    
    func getAllAnnonces(idAutomobiliste : String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "annonces/\(idAutomobiliste)"
        print(url)
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
    
    func getAllAnnoncesAvancee(idAutomobiliste : String, CodeVersion: String, Carburant: String, minAnnee: String, maxAnnee: String, minPrix: String, maxPrix: String, maxKm: String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
       // let url : String = BASE_URL + "annonces/\(idAutomobiliste)"
        var url : String = BASE_URL + "annonces/\(idAutomobiliste)"
        let params = "idAutomobiliste=\(idAutomobiliste)&CodeVersion=\(CodeVersion)&Carburant=\(Carburant)&minAnnee=\(minAnnee)&maxAnnee=\(maxAnnee)&minPrix=\(minPrix)&maxPrix=\(maxPrix)&maxKm=\(maxKm)"
        url = url + "?\(params)"
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
    
    func getMesAnnonces(idAutomobiliste : String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "automobiliste/\(idAutomobiliste)/annonces"
        print(url)
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
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createAnnonce(photo : UIImage, Prix : String, idAutomobiliste: String, CodeVersion: String, Couleur: String, Km: String, Annee: String, Carburant: String, Description: String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "vehicules/annonces"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["Prix": "\(Prix)", "idAutomobiliste": "\(idAutomobiliste)", "CodeVersion": "\(CodeVersion)", "Couleur" : "\(Couleur)", "Km" : "\(Km)", "Annee" : "\(Annee)", "Carburant" : "\(Carburant)", "Description" : "\(Description)"]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        let strs = String(decoding: request.httpBody!, as: UTF8.self)
        print(strs)

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = createBody(parameters: parameters,
                                boundary: boundary,
                                data: UIImageJPEGRepresentation(photo, 0.7)!,
                                mimeType: "image/jpg",
                                filename: "hello.jpg")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if (error != nil){
                onFailure(error!)
            } else {
                let strs = String(decoding: data!, as: UTF8.self)
                print(strs)
                onSuccess(data!)
            }
        })
        task.resume()
    }

    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"imageAnnonce\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }

    
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
