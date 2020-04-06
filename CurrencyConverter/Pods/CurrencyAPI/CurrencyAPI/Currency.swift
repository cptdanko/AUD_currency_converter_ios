//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 20/2/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation

/*
 Remember, the class and methods that need to be used outside
 the framework by Apps calling them need to be declared public
 */
public class Currency: Comparable, Codable {
    
    public var code: String = ""
    public var name: String = ""
    public var rate: Decimal = 0 //using Decimal because it conforms to Encodable & Decodable
    public var symbol: String = ""
    public var baseCurrency: String = ""
    public var lastUpdated: Date?
    
    private enum CodingKeys: String, CodingKey {
        case code
        case name
        case rate
        case symbol
        case baseCurrency
    }
    init() {}
    public required init(from decoder: Decoder) throws {
        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            self.code = try! values.decode(String.self, forKey: .code)
            self.name = try! values.decode(String.self, forKey: .name)
            self.rate = try! values.decode(Decimal.self, forKey: .rate)
            self.symbol = try! values.decode(String.self, forKey: .symbol)
            self.baseCurrency = try! values.decode(String.self, forKey: .baseCurrency)
        }
    }
    convenience init(code: String, rate: Decimal, symbol: String, name: String, baseCurrency: String) {
        self.init()
        self.code = code
        self.rate = rate
        self.symbol = symbol
        self.name = name
        self.baseCurrency = baseCurrency
    }
    
    public func stringToDisplayInUI() -> String {
       return "\(name) (\(code))"
    }
    //the methods below means the Currency object
    //conforms to the Comparable protocol so we can
    //sort the list of currencies to give consistent user exp
    public static func < (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.name < rhs.name
    }
       
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.name == rhs.name
    }
}

