//
//  Dictionary+HTTPParameters.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return "?\(parameterArray.joined(separator: "&"))"
    }
}
