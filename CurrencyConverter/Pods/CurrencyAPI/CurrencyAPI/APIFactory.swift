//
//  APIFactory.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 21/3/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.

import Foundation

public enum API_TYPE {
    case API_EX_RATE
    case BANK_1
}
/*
 So we have a function that just gives us a CurrencyAPI, it could be any
 external API, bank or any other provider as long it conforms to the
 Exchange Rate API protocol.
 */
public class APIFactory {
    //using this approach so we can return any API that conforms to the protocol
    public static func getCurrencyAPI(type: API_TYPE) -> ExchangeRateAPI? {
        var apiToReturn: ExchangeRateAPI?
        if type == .API_EX_RATE {
            apiToReturn =  APIDotExRate()
        } else if type == .BANK_1 {
            apiToReturn =  Bank1()
        }
        return apiToReturn
    }
}
