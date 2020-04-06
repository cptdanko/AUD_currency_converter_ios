//
//  DialogHelper.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 30/3/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation
import UIKit

class DialogHelper {
    
    let errDialogOkTxt = NSLocalizedString("dialog.view.ok", comment: "")
    
    static let shared = DialogHelper()
    
    func cantConvertCurrencyErr() -> UIAlertController {
        let hdr = NSLocalizedString("err.home.view.cantparse.hdr", comment: "")
        let msg = NSLocalizedString("err.home.view.cantparse.msg", comment: "")
        return errorDialog(title: hdr, messasge: msg, okTxt: errDialogOkTxt)
    }
    func getCurrencyFetchErr() -> UIAlertController {
        let hdr = NSLocalizedString("err.home.view.fetch.hdr", comment: "")
        let msg = NSLocalizedString("err.home.view.fetch.msg", comment: "")
        return errorDialog(title: hdr, messasge: msg, okTxt: errDialogOkTxt)
    }
    
    private func errorDialog(title: String, messasge: String, okTxt: String) -> UIAlertController{
        let alertCtrl = UIAlertController(title: title, message: messasge, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTxt, style: .default, handler: nil)
        alertCtrl.addAction(okAction)
        return alertCtrl
    }
    
}
