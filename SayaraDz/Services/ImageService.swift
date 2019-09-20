//
//  ImageService.swift
//  SayaraDz
//
//  Created by Mac on 6/21/19.
//  Copyright © 2019 mossab. All rights reserved.
//

import Foundation


class ImageService {
    static let sharedInstance = ImageService()
    func getImage(code: Int,onSuccess: @escaping(Data) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = BASE_URL + "images/versions/\(code)"
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
