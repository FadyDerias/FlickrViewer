//
//  FLPhoto.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import ObjectMapper

class FLPhoto: Mappable {
    
    var photoId: String?
    var ownerId: String?
    var secretId: String?
    var serverId: String?
    var farmId: Int?
    var title: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        photoId <- map["id"]
        ownerId <- map["owner"]
        secretId <- map["secret"]
        serverId <- map["server"]
        farmId <- map["farm"]
        title <- map["title"]

    }
}
