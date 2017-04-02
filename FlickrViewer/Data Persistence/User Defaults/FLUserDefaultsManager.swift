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
    
    func loadSearchParametersFromUserDefaults() -> NSDictionary? {
        let nextPageToLoad = defaults.value(forKey: pageToLoadKey) as? Int
        let searchText = defaults.value(forKey: lastUserSearchTextLey) as? String
        
        if let userSearchText = searchText, let pageToLoadNumber = nextPageToLoad {
            let searchParametersDictionary = [lastUserSearchTextLey:userSearchText,
                                              pageToLoadKey:pageToLoadNumber] as [String : Any]
            
            return searchParametersDictionary as NSDictionary
            
        } else {
            return nil
        }
        
    }
}
