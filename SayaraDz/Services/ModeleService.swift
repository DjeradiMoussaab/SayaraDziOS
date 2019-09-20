//
//  ModeleService.swift
//  SayaraDz
//
//  Created by Mac on 4/11/19.
//  Copyright © 2019 mossab. All rights reserved.
//


import Foundation
import SwiftyJSON

class ModeleService {
    static let sharedInstance = ModeleService()
    
    func getAllModeles(codeMarque: Int,onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "marques/\(codeMarque)/modeles"
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
    
}
