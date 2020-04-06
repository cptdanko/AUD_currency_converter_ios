//
//  ExRate-API.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 21/3/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation

public class APIDotExRate: ExchangeRateAPI {

    let EXTERNAL_API_URL: String = "https://api.exchangerate-api.com/v4/latest/"
    public func fetchExchangeRates(baseCur: String, successHandler: @escaping ([Currency]?, Error?, Date?) -> Void) {
        let urlStr = "\(EXTERNAL_API_URL)\(baseCur)"
        let url = URL(string: urlStr)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                //hmm...should we do this?
                //we will notify the user the last updated date for the currencies
                //in the UI in the event of an error get the currency objects
                //stored from UserDefaults
                let savedData = DBHelper.loadFromUD()
                successHandler(savedData.data, nil, savedData.saveDate)
            }
            do {
                if let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    var currencies:[Currency]? = [Currency]()
                    var lastUpdatedDate: Date? = nil
                    if let lastUpdated = result["time_last_updated"] as? Int64 {
                        lastUpdatedDate = Date(timeIntervalSince1970: Double(lastUpdated))
                    }
                    if let rates = result["rates"] as? [String: Any] {
                        for (key, value)  in rates {
                            if key.compare(baseCur) == .orderedSame {
                                continue
                            }
                            let rate = value as! NSNumber
                            let currency = Currency(code: key, rate: rate.decimalValue, symbol: key, name: "", baseCurrency: baseCur)
                            currency.lastUpdated = lastUpdatedDate
                            if let name = Locale.current.localizedString(forCurrencyCode: key) {
                                currency.name = name
                            }
                            currencies?.append(currency)
                        }
                        currencies?.sort()
                        successHandler(currencies, error, lastUpdatedDate)
                        DBHelper.saveToUD(currencies: currencies!, dateToSave: lastUpdatedDate)
                    }
                }
            } catch {
                //if we get here, then naturally nothing worked
                let savedData = DBHelper.loadFromUD()
                successHandler(savedData.data, error, savedData.saveDate)
            }
        }
        task.resume()
        return
    }
    /* added this method to ensure the user always sees the latest exchange rate
        Haven't added a fallback to resort to stored data
    */
    public func getExchangeRate(baseCur: String, code: String, successHandler: @escaping (_ currency: Currency?, _ err: Error?, _ lastUpdateDate: Date?) -> Void) {
        let urlStr = "\(EXTERNAL_API_URL)\(baseCur)"
        let url = URL(string: urlStr)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                let storedCurrency = self.getStoredCur(code)
                successHandler(storedCurrency.0, nil, storedCurrency.1)
            }
            do {
                if let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    var lastUpdatedDate: Date? = nil
                    if let lastUpdated = result["time_last_updated"] as? Int64 {
                        lastUpdatedDate = Date(timeIntervalSince1970: Double(lastUpdated))
                    }
                    var currency: Currency?
                    if let rates = result["rates"] as? [String: Any] {
                        for (key, value)  in rates {
                            let rate = value as! NSNumber
                            if key.compare(code) == .orderedSame {
                                let matchingCurrency = Currency(code: key, rate: rate.decimalValue, symbol: key, name: "", baseCurrency: baseCur)
                                if let name = Locale.current.localizedString(forCurrencyCode: key) {
                                    matchingCurrency.name = name
                                }
                                currency = matchingCurrency
                            }
                        }
                        successHandler(currency, nil, lastUpdatedDate)
                    }
                }
            } catch {
                //if we get here, then nothing worked and we are resorting to Currency
                //that we saved to persistant storage
                let storedCurrency = self.getStoredCur(code)
                successHandler(storedCurrency.0, nil, storedCurrency.1)
            }
        }
        task.resume()
        return
    }
    /*
     A little helper method so we don't have to write all this code everytime
     we need to fetch the currency from storage
     */
    private func getStoredCur(_ code: String) -> (Currency?, Date?) {
        let savedData = DBHelper.loadFromUD()
        var retVal: Currency?
        var lastUpdateDate: Date?
        if let storedCur = savedData.data {
            lastUpdateDate = savedData.saveDate
            retVal = storedCur.first { (currency) -> Bool in
                return currency.code.compare(code) == .orderedSame
            }
        }
        return (retVal, lastUpdateDate)
    }
}
