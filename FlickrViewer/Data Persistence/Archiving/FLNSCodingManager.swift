//
//  FLNSCodingManager.swift
//  FlickrViewer
//
//  Created by Fady on 4/8/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation

class FLNSCodingManager {
    
    static let sharedInstance = FLNSCodingManager()
    private let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    
    func savePhotosToRoomDirectory(flPhotosArray: NSMutableArray) {
        let archiveURL = documentsDirectory.appendingPathComponent("FADY")
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(flPhotosArray, toFile: archiveURL.path)
        
        if (isSuccessfulSave) {
            print("SAVE SUCCEEDED")
        } else {
            print("SAVE FAILED")
        }
    }
    
    func loadPhotosFromRoomDirectory() -> [FLPhoto]? {
        let archiveURL = documentsDirectory.appendingPathComponent("FADY")
        
        if let photos = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [FLPhoto] {
            return photos
        } else {
            return nil
        }
    }
}
