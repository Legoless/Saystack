//
//  SKProduct+Example.swift
//  Demo
//
//  Created by Dal Rupnik on 4/8/20.
//  Copyright © 2020 Unified Sense. All rights reserved.
//

import Foundation
import StoreKit

extension SKProduct {
    convenience init(productIdentifier: String, price: NSDecimalNumber, priceLocale: Locale = Locale.current, period: SKProductSubscriptionPeriod? = nil, introductoryPrice: SKProductDiscount? = nil) {
        self.init()
        setValue(productIdentifier, forKey: "productIdentifier")
        setValue(price, forKey: "price")
        setValue(priceLocale, forKey: "priceLocale")
        setValue(period, forKey: "subscriptionPeriod")
        setValue(introductoryPrice, forKey: "introductoryPrice")
    }
}

extension SKProductSubscriptionPeriod {
    convenience init(numberOfUnits: Int, periodUnit: SKProduct.PeriodUnit) {
        self.init()
        
        setValue(numberOfUnits, forKey: "numberOfUnits")
        setValue(periodUnit.rawValue, forKey: "unit")
    }
}

extension SKProductDiscount {
    convenience init (price: NSDecimalNumber, numberOfPeriods: Int, subscriptionPeriod: SKProductSubscriptionPeriod, priceLocale: Locale = Locale.current, paymentMode: SKProductDiscount.PaymentMode) {
        self.init()
        
        setValue(price, forKey: "price")
        setValue(numberOfPeriods, forKey: "numberOfPeriods")
        setValue(subscriptionPeriod, forKey: "subscriptionPeriod")
        setValue(priceLocale, forKey: "priceLocale")
        setValue(paymentMode.rawValue, forKey: "paymentMode")
    }
}
