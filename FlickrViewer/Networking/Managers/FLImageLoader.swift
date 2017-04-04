//
//  FLImageLoader.swift
//  FlickrViewer
//
//  Created by Fady on 4/4/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import UIKit

class FLImageLoader {
    
    static let sharedInstance = FLImageLoader()
    var cache = NSCache<AnyObject, AnyObject>()
    
    func imageForUrl(url: String,success: @escaping (_ image: UIImage?)-> Void, failure: @escaping (_ returnError: NSError) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            let data: NSData? = self.cache.object(forKey: url as AnyObject) as? NSData
            
            if let validData = data {
                let image = UIImage(data: validData as Data)
                DispatchQueue.main.async {
                    success(image)
                }
                
                return
            }
            
            let urlForRequest = URL(string: url)
            let request = NSMutableURLRequest(url: urlForRequest!)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest) { (data, response, networkingError) in
                guard let data = data , networkingError == nil
                    else {
                        failure(networkingError! as NSError)
                        print(networkingError!)
                        return
                }
                
                let image = UIImage(data: data)
                self.cache.setObject(data as AnyObject, forKey: url as AnyObject)
                DispatchQueue.main.async {
                    success(image)
                }
                
                return
            }
            
            task.resume()
        }
    }
}
