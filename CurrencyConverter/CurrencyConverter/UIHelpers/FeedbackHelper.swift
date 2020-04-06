//
//  FeedbackHelper.swift
//  CurrencyConverter
//
//  Created by Bhuman Soni on 20/2/20.
//  Copyright © 2020 Bhuman Soni. All rights reserved.
//

import Foundation
import UIKit


class FeedbackHelper {
    
    static let fbh = FeedbackHelper()
    
    enum Feedback {
        case LIGHT
        case MEDIUM
        case HEAVY
    }
    
    func triggerFeedback(ofType: Feedback?) {
        switch ofType {
            case .LIGHT:
                let impactGenerator = UIImpactFeedbackGenerator(style: .light)
                impactGenerator.impactOccurred()
            case .HEAVY:
                let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
                impactGenerator.impactOccurred()
            default:
               let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
               impactGenerator.impactOccurred()
            }
    }
}
