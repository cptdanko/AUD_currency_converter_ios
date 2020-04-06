//
//  HomeViewModel.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 30/3/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation
import UIKit
import CurrencyAPI

/*
 Note: This may not be the right way to implement
 the MVVM model? if so, then please implement yours
 */
class HomeViewModel {
    
    @IBOutlet var auInputTF: UITextField!
    @IBOutlet var foreignOutputTF: UITextField!
    @IBOutlet var lastUpdatedLbl: UILabel!
    
    init(auInputTF: UITextField, foreignOutputTF: UITextField, lastUpdatedLbl: UILabel) {
        self.foreignOutputTF = foreignOutputTF
        self.auInputTF = auInputTF
        self.lastUpdatedLbl = lastUpdatedLbl
    }
    //simple method for us to query the exchange rate API and update the UI
    func convertValue(selectedCurrency: Currency, currencyAPI: ExchangeRateAPI, hostVC: UIViewController) {
        if let val = auInputTF.text {
            foreignOutputTF.showLoadingIcon()
            //check if the currency has been selected
            //selectedCurrency
            currencyAPI.getExchangeRate(baseCur: Constants.CURRENCY_CODE.AUD, code: selectedCurrency.code) { (currency, err, lastUpdatedDate) in
                //just in case, the chances of this happening are quite low
                if err != nil || currency == nil {
                    let dialog = DialogHelper.shared.getCurrencyFetchErr()
                    hostVC.present(dialog, animated: true, completion: nil)
                }
                //if we are here, then we have got a currency object in return
                if let iVal = Decimal(string: val) {
                    let exchangeRate = selectedCurrency.rate
                    var fullConversion = iVal * exchangeRate
                    var rounded = Decimal()
                    //let convertedValue = round(fullConversion * 1000) / 1000
                    NSDecimalRound(&rounded, &fullConversion, 3, .plain)
                    //this is an important aspect of thread management in Swift
                    //we do this to update the UI without interrupting the
                    //user experience
                    DispatchQueue.main.async {
                        self.foreignOutputTF.text = "\(rounded)"
                        let lastUpdateLblTxt = NSLocalizedString("home.view.date.lastupdated", comment: "")
                        self.foreignOutputTF.hideLoadingIcon()
                        self.lastUpdatedLbl.isHidden = false
                        if let dateStr = lastUpdatedDate?.dateStr {
                            var updateLbl = "\(lastUpdateLblTxt)"
                            updateLbl.append(contentsOf: "\n\(dateStr)")
                            self.lastUpdatedLbl.text = updateLbl
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.foreignOutputTF.hideLoadingIcon()
                        let dialog = DialogHelper.shared.cantConvertCurrencyErr()
                        hostVC.present(dialog, animated: true) {
                            self.auInputTF.becomeFirstResponder()
                        }
                    }
                }
            }
        }
    }
}
