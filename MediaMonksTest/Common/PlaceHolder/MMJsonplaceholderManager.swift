//
//  MMJsonplaceholderManager.swift
//  MediaMonksTest
//
//  Created by iMac on 14/03/2019.
//  Copyright © 2019 iMac. All rights reserved.
//

import Foundation
import SwiftyJSON

class MMPlaceHolderManager {
    
    private static let baseURL = "https://jsonplaceholder.typicode.com"
    static let sharedInstance = MMPlaceHolderManager()
    
    private static let getPostsEndpoint = "/albums/"
    private static let getPhotosEndpont = "/photos/"
    private static let getPhotosWithAlbumIdEndPoint = "/photos?albumId="
    
    
    static func getAlbums(onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + MMPlaceHolderManager.getPostsEndpoint
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                let result = JSON(data: data!)
                onSuccess(result)
            }
        })
        task.resume()
    }
    
    static func getPhotoInfoWithAlbumId(albumId: Int, onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + MMPlaceHolderManager.getPhotosWithAlbumIdEndPoint + String(albumId)
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                let result = JSON(data: data!)
                onSuccess(result)
            }
        })
        task.resume()
    }
    
    static func getPhotosInfo(onSuccess: @escaping(JSON) -> Void, onFailure: @escaping(Error) -> Void){
        let url : String = baseURL + MMPlaceHolderManager.getPhotosEndpont
        let request: NSMutableURLRequest = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if(error != nil){
                onFailure(error!)
            } else{
                let result = JSON(data: data!)
                onSuccess(result)
            }
        })
        task.resume()
    }
    
    static func getImageFromUrl(url: String, result: @escaping (UIImage?) -> Void, fail: @escaping (Error?) -> Void) {
        
        let dataTask: URLSessionDataTask = URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { (
            data, response, error) -> Void in
            
            if error != nil {
                fail(error)
                return
            }
            if data != nil {
                if let image = UIImage(data: data!) {
                    result(image)
                    return
                }
            }
            result(nil)
            
        }
        dataTask.resume()
        
    }
    
    
}

