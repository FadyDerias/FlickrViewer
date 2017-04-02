//
//  AppDelegate.swift
//  FlickrViewer
//
//  Created by Fady on 3/28/17.
//  Copyright © 2017 orange. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setAppearance()
        return true
    }
    
    func setAppearance() {
        self.window?.backgroundColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red:1.00, green:0.40, blue:0.00, alpha:1.00)
        UINavigationBar.appearance().tintColor = UIColor.black
    }

}

