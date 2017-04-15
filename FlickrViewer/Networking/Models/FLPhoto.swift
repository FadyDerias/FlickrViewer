//
//  FLPhoto.swift
//  FlickrViewer
//
//  Created by Fady on 3/29/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import ObjectMapper

class FLPhoto: NSObject, NSCoding, Mappable {
    
    var photoId: String?
    var ownerId: String?
    var secretId: String?
    var serverId: String?
    var farmId: Int?
    var title: String?
    
    struct PropertyNSCodingKeys {
        static let photoId = "photoId"
        static let ownerId = "ownerId"
        static let secretId = "secretId"
        static let serverId = "serverId"
        static let farmId = "farmId"
        static let title = "title"
    }
    
    required init?(map: Map) {
    }
    
    init(photoId: String, ownerId: String, secretId: String, serverId:String, farmId:Int, title: String ) {
        self.photoId = photoId
        self.ownerId = ownerId
        self.secretId = secretId
        self.serverId = serverId
        self.farmId = farmId
        self.title = title
    }
    
    func mapping(map: Map) {
        
        photoId <- map["id"]
        ownerId <- map["owner"]
        secretId <- map["secret"]
        serverId <- map["server"]
        farmId <- map["farm"]
        title <- map["title"]
        
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(photoId, forKey: PropertyNSCodingKeys.photoId)
        aCoder.encode(ownerId, forKey: PropertyNSCodingKeys.ownerId)
        aCoder.encode(secretId, forKey: PropertyNSCodingKeys.secretId)
        aCoder.encode(serverId, forKey: PropertyNSCodingKeys.serverId)
        aCoder.encode(farmId, forKey: PropertyNSCodingKeys.farmId)
        aCoder.encode(title, forKey: PropertyNSCodingKeys.title)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        guard let unarchivedPhotoId = aDecoder.decodeObject(forKey: PropertyNSCodingKeys.photoId) as? String,
            let unarchivedOwnerId = aDecoder.decodeObject(forKey: PropertyNSCodingKeys.ownerId) as? String,
            let unarchivedSecretId = aDecoder.decodeObject(forKey: PropertyNSCodingKeys.secretId) as? String,
            let unarchivedServerId = aDecoder.decodeObject(forKey: PropertyNSCodingKeys.serverId) as? String,
            let unarchivedFarmId = aDecoder.decodeObject(forKey: PropertyNSCodingKeys.farmId) as? Int,
            let unarchivedTitle = aDecoder.decodeObject(forKey: PropertyNSCodingKeys.title) as? String
            else {
                return nil
        }
        
        self.init(photoId: unarchivedPhotoId, ownerId: unarchivedOwnerId, secretId: unarchivedSecretId, serverId:unarchivedServerId, farmId:unarchivedFarmId, title: unarchivedTitle)
        
    }
    
}
