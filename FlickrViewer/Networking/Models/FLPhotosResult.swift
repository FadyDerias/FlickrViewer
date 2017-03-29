//
//  FLPhotosResult.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import ObjectMapper

class FLPhotosResult: Mappable {
    
    var photosList: FLPhotosList?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        photosList <- map["photos"]
    }
    
}
