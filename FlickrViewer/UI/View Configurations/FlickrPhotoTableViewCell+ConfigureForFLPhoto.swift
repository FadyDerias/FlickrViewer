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
        
        if let imageUrl = flPhoto.urlForFLPhotoImage() {
            let flPhotoDownloader = FLPhotoDownloader()
            flPhotoDownloader.downloadImage(url: imageUrl, success: { (data) in
                OperationQueue.main.addOperation({
                    self.photoImageView.image = UIImage(data: data)
                })
            })
        }
    }
}
