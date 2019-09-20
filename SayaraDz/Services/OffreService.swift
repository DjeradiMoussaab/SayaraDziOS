//
//  OffreService.swift
//  SayaraDz
//
//  Created by Mac on 8/26/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation
import SwiftyJSON

class OffreService {
    static let sharedInstance = OffreService()
    
    func getAllOffres(idAnnonce : String, onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "vehicules/annonces/\(idAnnonce)/offres"
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
    
    
}
