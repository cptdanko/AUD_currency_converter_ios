//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 20/2/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import UIKit
import CurrencyAPI

/*
 This uses the pub
 */

class HomeViewController: UIViewController {

    var currenciesPickerData = [Currency]()
    var selectedCurrency: Currency?
    var lastUpdateDate: Date?
    
    @IBOutlet var currencySelectorPV: UIPickerView!
    @IBOutlet var auInputTF: UITextField!
    @IBOutlet var foreignOutputTF: UITextField!
    @IBOutlet var equalLbl: UILabel!

    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var triggerBtn: UIButton!
    @IBOutlet var lastUpdatedLbl: UILabel!
    var homeView: HomeViewModel!
    
    let currencyAPI = APIFactory.getCurrencyAPI(type: .API_EX_RATE)!
    override func viewDidAppear(_ animated: Bool) {
        homeView = HomeViewModel(auInputTF: auInputTF, foreignOutputTF: foreignOutputTF, lastUpdatedLbl: lastUpdatedLbl)
        //this is just in case it takes time for the c
        currencySelectorPV.addActivityIndicator()
        
        currencyAPI.fetchExchangeRates(baseCur: Constants.CURRENCY_CODE.AUD) { (currencies, error, date) in
           if error != nil {
                let alertCtrl = DialogHelper.shared.getCurrencyFetchErr()
                self.present(alertCtrl, animated: true, completion: nil)
           }
           if let cur = currencies {
                self.currenciesPickerData = cur
                self.lastUpdateDate = date
                self.reloadPickerView()
                self.selectedCurrency = cur[0] //so SelectedCurrency is almost never nil
           }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UIUtilities.roundLabels(views: [equalLbl,auInputTF,foreignOutputTF,triggerBtn,currencySelectorPV,titleLbl, lastUpdatedLbl], radius: Constants.UI_BTN_ROUND_RADIUS)
    }
    //method to be made redundant very soon
    //because we really don't need it
    @IBAction func convertCurrency(_ sender: Any) {
        FeedbackHelper.fbh.triggerFeedback(ofType: .MEDIUM)
        homeView.convertValue(selectedCurrency: selectedCurrency!, currencyAPI: currencyAPI, hostVC: self)
    }
}

//MARK: PickerView methods
extension HomeViewController:UIPickerViewDataSource, UIPickerViewDelegate {
    private func reloadPickerView() {
        DispatchQueue.main.async {
            self.currencySelectorPV.reloadAllComponents()
            self.currencySelectorPV.removeIndicatorOnLoad()
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenciesPickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCurrency = currenciesPickerData[row]
        homeView.convertValue(selectedCurrency: selectedCurrency!, currencyAPI: currencyAPI, hostVC: self)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currencyAtRow = currenciesPickerData[row]
        return currencyAtRow.stringToDisplayInUI()
    }
}

//MARK: UITextField delegate methods
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        homeView.convertValue(selectedCurrency: selectedCurrency!, currencyAPI: currencyAPI, hostVC: self)
    }
}
