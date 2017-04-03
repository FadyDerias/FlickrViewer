//
//  UIAlertController+NetworkingErrors.swift
//  FlickrViewer
//
//  Created by Fady on 3/30/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    static func defaultNetworkingAlertController(_ retryHandler: @escaping (() -> Void), _ cancelHandler: @escaping (() -> Void)) -> UIAlertController {
        let alertController = UIAlertController(title: "Error",
                                                message: "Could not connect to the internet. Would you like to try again?",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (alertController) in
            cancelHandler()
        }
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (alertController) in
            retryHandler()
        }
        
        alertController.addAction(retryAction)
        alertController.addAction(cancelAction)
        
        return alertController
    }
    
    
    
    static func searchResultsAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: "Search Results",
                                                message: "Sorry, no search results are available for this input search text.",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        return alertController
        
    }
}
