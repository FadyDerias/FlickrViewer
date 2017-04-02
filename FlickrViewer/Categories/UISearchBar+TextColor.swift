//
//  UISearchBar+TextColor.swift
//  FlickrViewer
//
//  Created by Fady on 4/3/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import UIKit

extension UISearchBar {
    
    func updateFontColorForSearchText() {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor(red:1.00, green:0.40, blue:0.00, alpha:1.00)
    }
}
