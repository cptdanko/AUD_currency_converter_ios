//
//  UIViewGeneral.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 6/4/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    /*
     The methods show and hide activity indicator to show and hide
     activity indicators on UIControls in the app. e.g. in this app,
     after adding the value to be converted in the aud amount input
     UITextField, we can show a loading indicator on the foreign output
     UITextField, while the app fetches the exchange rate information
     from the network and we apply the conversaion
     */
    func showLoadingIcon() {
        let activityIndicator = UIActivityIndicatorView(frame: self.bounds)
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    func hideLoadingIcon() {
        for view in subviews {
            if let acIndicator =  view as? UIActivityIndicatorView {
                DispatchQueue.main.async() {
                    acIndicator.removeFromSuperview()
                }
            }
        }
    }
    
}
