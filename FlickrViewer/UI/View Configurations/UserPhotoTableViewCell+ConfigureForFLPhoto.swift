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
            self.photoImageView.sd_setImage(with: imageUrl)
        }
    }
}
