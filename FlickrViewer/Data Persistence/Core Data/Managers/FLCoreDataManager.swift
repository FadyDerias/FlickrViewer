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

 
    func savePhotoToCoreData(flPhoto: FLPhoto) {
        
        let flPhotoEntity = NSEntityDescription.entity(forEntityName: "FLickrPhoto",
                                                       in: context)
    
        if let entity = flPhotoEntity {
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
    
    func performActionForPhotosResultsInCoreData(deleteCoreData: Bool) -> [FLPhoto]? {
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "FLickrPhoto")
        
        do {
            let results: [NSManagedObject] = try context.fetch(fetchRequest)
            return performActionForHomeSearchTableViewDataSource(managedObjects: results, deleteCoreData: deleteCoreData)
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func performActionForHomeSearchTableViewDataSource(managedObjects: [NSManagedObject], deleteCoreData: Bool) -> [FLPhoto]? {
        var flPhotosArray = NSArray() as! [FLPhoto]

        for resultObject in managedObjects {
            if (deleteCoreData) {
                context.delete(resultObject)
            } else {
                let flPhotoId = resultObject.value(forKeyPath: "photoId") as! String
                let flOwnerId = resultObject.value(forKeyPath: "ownerId") as! String
                let flSecretId = resultObject.value(forKeyPath: "secretId") as! String
                let flServerId = resultObject.value(forKeyPath: "serverId") as! String
                let flFarmId = resultObject.value(forKeyPath: "farmId") as! Int
                let fltitle = resultObject.value(forKeyPath: "title") as! String
                
                let flPhoto = FLPhoto(photoId: flPhotoId, ownerId: flOwnerId, secretId: flSecretId, serverId: flServerId, farmId: flFarmId, title: fltitle)
                
                flPhotosArray.append(flPhoto)
            }
            
        }
        
        if(deleteCoreData) {
            return nil
        } else {
            return flPhotosArray
        }
    }
    
}
