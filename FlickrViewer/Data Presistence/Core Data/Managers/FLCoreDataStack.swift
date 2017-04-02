//
//  FLCoreDataManager.swift
//  FlickrViewer
//
//  Created by Fady on 4/1/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import CoreData

//Project's deployment target is set to iOS 9.0, the new core data boiler plate for Xcode 8.0 & Swift 3 is
//only available for targets < iOS 10.0. The below boiler plate has been transformed from Swift 2.2 to Swift 3 to
//meet up with the project's deployment target. @available(iOS 10, *) approach has been disregarded.

class FLCoreDataStack {
    
    static let sharedInstance = FLCoreDataStack()

    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "FlickrViewer", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("FlickrViewer.sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch let  error as NSError {
            print("Ops there was an error \(error.localizedDescription)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }()
    
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Ops there was an error \(error.localizedDescription)")
                abort() 
            }
        } 
    }
}
