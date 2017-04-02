//
//  UserPhotoTableViewCell+ConfigureForFLPhoto.swift
//  FlickrViewer
//
//  Created by Fady on 3/31/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import UIKit

extension UserPhotoTableViewCell {
    
    func configureForFlickrPhotoData(flPhoto: FLPhoto) {
        self.photoTitleLabel.text = flPhoto.title
        
        if let imageUrl = flPhoto.urlForFLPhotoImage() {
            FLImageLoader.sharedInstance.imageForUrl(url: imageUrl, success: { (image) in
                self.photoImageView.image = image
            }, failure: { (error) in
                print("Error downloading image: \(error)")
            })
        }
    }
}
