//
//  FLCoreDataManager.swift
//  FlickrViewer
//
//  Created by Fady on 4/2/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import CoreData

class FLCoreDataManager {
    
    static let sharedInstance = FLCoreDataManager()
    private var context = FLCoreDataStack.sharedInstance.managedObjectContext
    
 
    func savePhotoToCoreData(flickrPhotoEntity: NSEntityDescription?, flPhoto: FLPhoto) {
    
        if let entity = flickrPhotoEntity {
            let flickrPhotoManagedObject = NSManagedObject(entity: entity,
                                                           insertInto: context)
            
            flickrPhotoManagedObject.setValue(flPhoto.farmId, forKeyPath: "farmId")
            flickrPhotoManagedObject.setValue(flPhoto.photoId, forKeyPath: "photoId")
            flickrPhotoManagedObject.setValue(flPhoto.ownerId, forKeyPath: "ownerId")
            flickrPhotoManagedObject.setValue(flPhoto.secretId, forKeyPath: "secretId")
            flickrPhotoManagedObject.setValue(flPhoto.serverId, forKeyPath: "serverId")
            flickrPhotoManagedObject.setValue(flPhoto.title, forKeyPath: "title")
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
