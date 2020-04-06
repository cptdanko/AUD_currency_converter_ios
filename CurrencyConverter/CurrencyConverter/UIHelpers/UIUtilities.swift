//
//  UIUtilities.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 20/2/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation
import UIKit

class UIUtilities {
    
    static func roundLabels(views: [UIView], radius: CGFloat) {
        for view in views {
            view.layer.cornerRadius = radius
            view.layer.masksToBounds = true
        }
    }
}

extension UIPickerView {
    
    func addActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(frame: self.bounds)
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    func removeIndicatorOnLoad() {
        for view in subviews {
            if let acIndicator =  view as? UIActivityIndicatorView {
                DispatchQueue.main.async() {
                    acIndicator.removeFromSuperview()
                }
            }
        }
    }
}
