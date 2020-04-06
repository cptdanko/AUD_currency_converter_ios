//
//  API.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 20/2/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation

/*
 This was implemented in the original version of the app as it was
 originally built using one of the big bank's exchange rate API.
 All that code has been removed for privacy reasons
 */
public class Bank1: ExchangeRateAPI {
    //add the url for whichever bank you are getting the data from 
    internal var EXTERNAL_API_URL: String = ""
    public func getExchangeRate(baseCur: String, code: String, successHandler: @escaping (Currency?, Error?, Date?) -> Void) {}
    public func fetchExchangeRates(baseCur: String, successHandler: @escaping ([Currency]?, Error?, Date?) -> Void) { }
}
