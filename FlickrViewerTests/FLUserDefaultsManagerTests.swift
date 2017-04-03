//
//  FLUserDefaultsTests.swift
//  FlickrViewer
//
//  Created by Fady on 4/4/17.
//  Copyright © 2017 orange. All rights reserved.
//

import XCTest
@testable import FlickrViewer

class FLUserDefaultsManagerTests: XCTestCase {
    
    var userDefaultsManager: FLUserDefaultsManager! = nil
    var currentSearchText: String!
    var previousSearchText: String!
    var pageToLoad: Int!
    
    override func setUp() {
        super.setUp()
        userDefaultsManager = FLUserDefaultsManager.sharedInstance
        currentSearchText = "Flower"
        previousSearchText = "Apple"
        pageToLoad = 1
    }
    
    override func tearDown() {
        super.tearDown()
        userDefaultsManager = nil
        currentSearchText = nil
        previousSearchText = nil
        pageToLoad = nil
    }
    
    func testSavingUserSearchParametersToUserDefaults() {
        userDefaultsManager.saveSearchParametersInUserDefaults(nextPageToLoad: pageToLoad, userInputSearchText: currentSearchText, userPreviousSearchText: previousSearchText)
        
        let searchParameterDictionary = userDefaultsManager.loadSearchParametersFromUserDefaults()
        
        XCTAssert(searchParameterDictionary?.count == 3)
    }

    
}
