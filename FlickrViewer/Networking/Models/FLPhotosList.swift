//
//  FLPhotosList.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import ObjectMapper

class FLPhotosList: Mappable {
    
    var page: Int?
    var pages: Int?
    var perPage: Int?
    var total: String?
    var photos: [FLPhoto]?
    var stat: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {        
        page <- map["page"]
        pages <- map["pages"]
        perPage <- map["perpage"]
        total <- map["total"]
        photos <- map["photo"]
        stat <- map["stat"]
    }
}
