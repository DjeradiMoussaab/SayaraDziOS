//
//  VersionService.swift
//  SayaraDz
//
//  Created by Mac on 4/12/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
import SwiftyJSON

class VersionService {
    static let sharedInstance = VersionService()
    
    func getAllVersions(codeModele: Int,onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "marques/modeles/\(codeModele)/versions"
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
    
    func getVersion(codeVersion: Int,onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "marques/modeles/versions/\(codeVersion)"
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
    
    func getAllversionsSuivies(idAutomobiliste: String,onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "suivies/versions?automobiliste=\(idAutomobiliste)&page=0"
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        print(url)
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
