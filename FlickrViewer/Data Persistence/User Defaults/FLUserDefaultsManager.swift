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
    let userSearchTextKey = "searchText"
    let userPreviousSearchTextKey = "previousSearchText"
    
    func saveSearchParametersInUserDefaults(nextPageToLoad: Int,userInputSearchText: String, userPreviousSearchText: String) {
        
        defaults.set(nextPageToLoad, forKey: pageToLoadKey)
        defaults.set(userInputSearchText, forKey: userSearchTextKey)
        defaults.set(userInputSearchText, forKey: userSearchTextKey)
        defaults.set(userPreviousSearchText, forKey: userPreviousSearchTextKey)

        defaults.synchronize()
    }
    
    func loadSearchParametersFromUserDefaults() -> NSDictionary? {
        let nextPageToLoad = defaults.value(forKey: pageToLoadKey) as? Int
        let searchText = defaults.value(forKey: userSearchTextKey) as? String
        let previousSearchText = defaults.value(forKey: userPreviousSearchTextKey) as? String
        
        if let userSearchText = searchText, let pageToLoadNumber = nextPageToLoad {
            let searchParametersDictionary = [userSearchTextKey:userSearchText,
                                              userPreviousSearchTextKey:previousSearchText as Any,
                                              pageToLoadKey:pageToLoadNumber] as [String : Any]
            
            return searchParametersDictionary as NSDictionary
            
        } else {
            return nil
        }
        
    }
}
