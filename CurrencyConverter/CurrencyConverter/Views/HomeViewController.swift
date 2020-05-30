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
        textField.textAlignment = .center
        return textField
    }()

    lazy var foreignOutputTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false
        textField.placeholder = "Foreign money I get"
        textField.contentMode = .center
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Last updated at"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    var triggerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Trigger", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    var currenciesPickerData = [Currency]()
    var selectedCurrency: Currency?
    var lastUpdateDate: Date?
    
    var homeView:HomeViewModel!
    
    let currencyAPI = APIFactory.getCurrencyAPI(type: .API_EX_RATE)!
    
    override func viewDidAppear(_ animated: Bool) {
        //homeView = HomeViewModel(masterView: view)
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
                DispatchQueue.main.async {
                    self.lastUpdatedLbl.text = "\(self.lastUpdatedLbl.text!)\n\(date!.dateStr)"
                }
           }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        currencySelectorPV.delegate = self
        auInputTF.delegate = self
        triggerButton.addTarget(self, action: #selector(loadCurrencies), for: .allTouchEvents)
    }
    @objc func loadCurrencies() {
        currencySelectorPV.reloadAllComponents()
    }
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLbl)
        view.addSubview(currencySelectorPV)
        view.addSubview(triggerButton)
        view.addSubview(lastUpdatedLbl)
        let margins = view.safeAreaLayoutGuide
        
        let currencyStackView = UIStackView()
        view.addSubview(currencyStackView)
        currencyStackView.translatesAutoresizingMaskIntoConstraints = false
        currencyStackView.spacing = 10.0
        currencyStackView.axis = .horizontal
                
        currencyStackView.addArrangedSubview(auInputTF)
        currencyStackView.addArrangedSubview(equalLbl)
        currencyStackView.addArrangedSubview(foreignOutputTF)
        currencyStackView.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            titleLbl.topAnchor.constraint(equalTo: margins.topAnchor, constant: 15),
            titleLbl.heightAnchor.constraint(equalToConstant: 40),
            
            currencySelectorPV.topAnchor.constraint(greaterThanOrEqualTo: titleLbl.bottomAnchor, constant: 30),
            currencySelectorPV.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            currencySelectorPV.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            currencySelectorPV.widthAnchor.constraint(lessThanOrEqualTo: margins.widthAnchor, multiplier: 1),
            currencySelectorPV.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.4),
            
            currencyStackView.topAnchor.constraint(equalTo: currencySelectorPV.bottomAnchor, constant: 20.0),
            currencyStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10.0),
            currencyStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10.0),
            currencyStackView.heightAnchor.constraint(equalToConstant: CGFloat(40.0)),
            
            lastUpdatedLbl.topAnchor.constraint(equalTo: currencyStackView.bottomAnchor, constant: 20.0),
            lastUpdatedLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10.0),
            lastUpdatedLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10.0),
            lastUpdatedLbl.heightAnchor.constraint(equalToConstant: CGFloat(60.0)),
            
            triggerButton.topAnchor.constraint(equalTo: lastUpdatedLbl.bottomAnchor, constant: 50),
            triggerButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
            triggerButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -10),
            triggerButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 10),
            triggerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    //method to be made redundant very soon
    //because we really don't need it
    @IBAction func convertCurrency(_ sender: Any) {
        FeedbackHelper.fbh.triggerFeedback(ofType: .MEDIUM)
        homeView.convertValue(selectedCurrency: selectedCurrency!, currencyAPI: currencyAPI, hostVC: self)
    }
    /*
     This method is only added here for debugging purposes
     */
    func addBorder(view: UIView) {
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor.green.cgColor
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
        //homeView.convertValue(selectedCurrency: selectedCurrency!, currencyAPI: currencyAPI, hostVC: self)
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currencyAtRow = currenciesPickerData[row]
        return currencyAtRow.stringToDisplayInUI()
    }
}

//MARK: UITextField delegate methods
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text)
        return textField.resignFirstResponder()
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        let enteredVal = textField.text!
        print(enteredVal)
        textField.resignFirstResponder()
        //homeView.convertValue(selectedCurrency: selectedCurrency!, currencyAPI: currencyAPI, hostVC: self)
    }
    private func convertValue(val: String, selectedCurrency: Currency, currencyAPI: ExchangeRateAPI, hostVC: UIViewController) {
        self.currencyAPI.getExchangeRate(baseCur: Constants.CURRENCY_CODE.AUD, code: selectedCurrency.code) { (currency, err, date) in
            if err != nil {
                guard let iVal = Decimal(string:val) else {
                    return
                }
                let exchangeRate = selectedCurrency.rate
                var fullConversion = iVal * exchangeRate
                var rounded = Decimal()
                //let convertedValue = round(fullConversion * 1000) / 1000
                NSDecimalRound(&rounded, &fullConversion, 3, .plain)
                DispatchQueue.main.async {
                    self.foreignOutputTF.text = "\(rounded)"
                    let lastUpdateLblTxt = NSLocalizedString("home.view.date.lastupdated", comment: "")
                    self.foreignOutputTF.hideLoadingIcon()
                    self.lastUpdatedLbl.isHidden = false
                    /*if let dateStr = lastUpdatedDate?.dateStr {
                        var updateLbl = "\(lastUpdateLblTxt)"
                        updateLbl.append(contentsOf: "\n\(dateStr)")
                        self.lastUpdatedLbl.text = updateLbl
                    }*/
                }
            }
            
        }
    }
}
