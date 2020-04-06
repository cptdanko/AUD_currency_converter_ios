//
//  DBHelper.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 24/3/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation

/*
 Current DB is UD i.e. UserDefaults
 ALternative: CoreData? Firebase.FireStore, AWS Amplify? 什么都
 */
public class DBHelper {
    //LET'S HAVE A FEW STATIC METHODS TO SAVE CURRENCIES TO DATA
    private static let SAVE_KEY = "DB_CURRENCY"
    private static  let TIME_LAST_SAVED = "TIME_LAST_SAVED"
    
    static func saveToUD(currencies: [Currency], dateToSave: Date?) {
        let data = try? JSONEncoder().encode(currencies)
        UserDefaults.standard.set(data, forKey: SAVE_KEY)
        let saveDate = dateToSave ?? Date()
        UserDefaults.standard.set(saveDate, forKey: TIME_LAST_SAVED)
    }
    //UD -> UserDefaults so load from UserDefaults
    static func loadFromUD() -> (data: [Currency]?, saveDate: Date?) {
        var currencies: (data: [Currency]?, saveDate: Date?)?
        currencies?.data = nil
        currencies?.saveDate = nil
        if let data = UserDefaults.standard.value(forKey: SAVE_KEY) as? Data {
            currencies?.data = try? JSONDecoder().decode([Currency].self, from: data)
            currencies?.saveDate = UserDefaults.standard.value(forKey: TIME_LAST_SAVED) as? Date
        }
        return currencies!
    }
}
