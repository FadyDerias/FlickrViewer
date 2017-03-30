//
//  FLPhoto+URLForPhoto.swift
//  FlickrViewer
//
//  Created by Fady on 3/30/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation

extension FLPhoto {
    
    func urlForFLPhotoImage() -> URL? {
        
        if let farmId = self.farmId, let serverID = self.serverId, let photoId = self.photoId, let secretId = self.secretId {
            let urlString = "https://farm\(farmId).staticflickr.com/\(serverID)/\(photoId)_\(secretId).jpg"
            return URL(string: urlString)!
        } else {
            return nil
        }
    }
}
