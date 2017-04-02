//
//  UITableViewCell+AccessoryTintColor.swift
//  FlickrViewer
//
//  Created by Fady on 4/3/17.
//  Copyright © 2017 orange. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    func prepareDisclosureIndicator() {
        for case let button as UIButton in subviews {
            let image = button.backgroundImage(for: .normal)?.withRenderingMode(.alwaysTemplate)
            button.setBackgroundImage(image, for: .normal)
        }
    }
}
