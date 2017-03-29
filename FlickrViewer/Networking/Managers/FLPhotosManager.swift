//
//  FLPhotosManager.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation

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
                                    "nojsoncallback":"1"] as [String : Any]
        
        let httpParameters = parametersDictionary.stringFromHttpParameters()
        let urlString = searchBaseURL.appending(httpParameters)
        
        return URL(string: urlString)!
        
    }
    
}
