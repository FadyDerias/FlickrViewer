//
//  FlickrPhotoTableViewCell+ConfigureForFLPhoto.swift
//  FlickrViewer
//
//  Created by Fady on 3/30/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import UIKit

extension FlickrPhotoTableViewCell {
    
    func configureForFlickrPhotoData(flPhoto: FLPhoto) {
        self.photoTitleLabel.text = flPhoto.title
    }
}
