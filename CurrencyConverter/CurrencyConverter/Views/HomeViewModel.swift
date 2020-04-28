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
    
    lazy var currencySelectorPV: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    lazy var auInputTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        textField.placeholder = "Australian $ I have"
        return textField
    }()
    
    lazy var foreignOutputTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false
        textField.placeholder = "Foreign money I get"
        return textField
    }()
    
    lazy var equalLbl:UILabel = {
       let label = UILabel()
        label.text = "="
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var titleLbl:UILabel = {
        let label = UILabel()
        label.text = "AUD($) 🦘🐨 Converter"
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    lazy var lastUpdatedLbl: UILabel = {
        let label = UILabel()
        label.text = "Last updated at"
        return label
    }()
    
    var currenciesPickerData = [Currency]()
    var selectedCurrency: Currency?
    var lastUpdateDate: Date?
    
    let masterView: UIView!
    let currencyAPI = APIFactory.getCurrencyAPI(type: .API_EX_RATE)!
    init(masterView: UIView) {
        self.masterView = masterView
        self.masterView.backgroundColor = .white
        setupAndPosition()
        UIUtilities.roundLabels(views: [titleLbl], radius: Constants.UI_BTN_ROUND_RADIUS)
    }
    private func setupAndPosition() {
        masterView.addSubview(titleLbl)
        masterView.addSubview(currencySelectorPV)
        let margins = masterView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            titleLbl.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            titleLbl.heightAnchor.constraint(equalToConstant: 40),
            
            currencySelectorPV.topAnchor.constraint(greaterThanOrEqualTo: titleLbl.bottomAnchor, constant: 30),
            currencySelectorPV.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
            currencySelectorPV.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 10),
        ])
        
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

