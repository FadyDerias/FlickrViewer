//
//  FLPhotosManager.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import ObjectMapper

class FLPhotosManager {
    
    let apikey = "8bd0e104fbbbfe0a6d1b6a557f1f4365"
    let appSecret = "9a067a565d6244e4"
    
    func setupURLForPhotosSearchByText(text: String, perPage: Int, page: Int) -> URL {

        let searchBaseURL = "https://api.flickr.com/services/rest/"
        let parametersDictionary = ["method":"flickr.photos.search",
                                    "api_key":self.apikey,
                                    "text":"\(text)",
                                    "per_page":"\(perPage)",
                                    "page": "\(page)",
                                    "format":"json",
                                    "nojsoncallback":"1"]
        
        let httpParameters = parametersDictionary.stringFromHttpParameters()
        let urlString = searchBaseURL.appending(httpParameters)
        
        return URL(string: urlString)!
    }
    
    func fetchPhotosBySearch(page: Int, userText: String, perPage: Int, success: @escaping (_ photosResult: FLPhotosResult) -> Void, failure: @escaping (_ returnError: NSError) -> Void) {
        
        let urlForRequest = setupURLForPhotosSearchByText(text: userText, perPage: perPage, page: page)
        let request = NSMutableURLRequest(url: urlForRequest)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, networkingError) in
            guard let data = data , networkingError == nil
                else {
                    failure(networkingError! as NSError)
                    print(networkingError!)
                    return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,AnyObject>
                if let photosResult = Mapper<FLPhotosResult>().map(JSONObject: jsonResponse) {
                    success(photosResult)
                } else {
                    print("Error Parsing data from jsonObject")
                }
            } catch {
                print("JSON error: \(error)")
            }
        }
        
        task.resume()
    }
    
}
