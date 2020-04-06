//
//  ExchangeRateAPI.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 25/3/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation
/*
 A protocol that all Exchange Rates API should conform to
 We could have exchange rates API for several banks and they could
 all conform to this
 */
public protocol ExchangeRateAPI {
    /* baseCur = Base Currency e.g. AUD, GBP etc */
    func fetchExchangeRates(baseCur: String, successHandler: @escaping (_ exRates: [Currency]?, _ err: Error?, _ lastUpdateDate: Date?) -> Void)
    func getExchangeRate(baseCur: String, code: String, successHandler:  @escaping (_ currency: Currency?, _ err: Error?, _ lastUpdateDate: Date?) -> Void)
}
