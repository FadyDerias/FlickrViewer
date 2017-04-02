//
//  FLUserDefaultsManager.swift
//  FlickrViewer
//
//  Created by Fady on 4/2/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation

class FLUserDefaultsManager {
    
    static let sharedInstance = FLUserDefaultsManager()
    private let defaults: UserDefaults = UserDefaults.standard
    let pageToLoadKey = "nextPageToLoad"
    let lastUserSearchTextLey = "searchText"
    
    func saveSearchParametersInUserDefaults(nextPageToLoad: Int,userInputSearchText: String ) {
        
        defaults.set(nextPageToLoad, forKey: pageToLoadKey)
        defaults.set(userInputSearchText, forKey: lastUserSearchTextLey)
        defaults.synchronize()
    }
    
