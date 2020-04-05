//
//  SKProductFormatter.swift
//  Saystack
//
//  Created by Dal Rupnik on 4/5/20.
//  Copyright © 2020 Unified Sense. All rights reserved.
//

import Foundation
import StoreKit

public class SKProductFormatter : Formatter {
    public enum ProductComponent {
        case subscriptionDuration
        case subscriptionDurationUnit
        case subscriptionPrice
        
        // Introductionary Price
        case introductoryPriceDuration
        case introductoryPriceDurationUnit
        case introductoryPrice
        case introductoryPriceMode // For trial
    }
    
    public enum PriceFormatStyle {
        case noConversion   // Will never convert price.
        case week           // Will convert prices to weekly price.
        case day            // Will convert prices to daily price.
        case month          // Will convert prices to monthly price.
        
        var targetUnit : SKProduct.PeriodUnit? {
            switch self {
            case .week:
                return .week
            case .day:
                return .day
            case .month:
                return .month
            case .noConversion:
                return nil
            }
        }
    }
    
    public enum DurationUnitFormatStyle {
        case normal             // Will format duration as "month", "year"
        case short              // Will format duration as "mo", "yr"
    }
    
    /// All formatted components that will be output as a string
    public var formatComponents: [ProductComponent] = [ .subscriptionPrice, .subscriptionDurationUnit ]
    
    public var priceFormatStyle : PriceFormatStyle = .noConversion
    public var durationUnitFormatStyle : DurationUnitFormatStyle = .normal
    public var durationUnitSeparator : String? = nil
    
    public var usePlural : Bool = true
    public var convertToQuarter : Bool = false
    public var componentSeparator = " "
    
    public func componentStrings(from product: SKProduct) -> [String] {
        return formatComponents.compactMap { format(component: $0, with: product) }
    }
    
    public func string(from product: SKProduct) -> String? {
        let formattedComponents = componentStrings(from: product)
        
        guard formattedComponents.count > 0 else {
            return nil
        }
        
        return formattedComponents.joined(separator: componentSeparator)
    }
    
    private func format(component: ProductComponent, with product: SKProduct) -> String? {
        guard let subscriptionPeriod = product.subscriptionPeriod else {
            return nil
        }
        
        switch component {
        case .subscriptionDuration:
            return formatDuration(product.subscriptionPeriod)
        case .subscriptionDurationUnit:
            return formatDurationUnit(subscriptionPeriod)
        case .subscriptionPrice:
            let formatter = priceFormatter(locale: product.priceLocale)
            
            if priceFormatStyle == .noConversion {
                return formatter.string(from: product.price)!
            }
            else if let targetUnit = priceFormatStyle.targetUnit {
                // We must do a price converstion to the correct price.
                return formatter.string(from: convert(price: product.price, from: subscriptionPeriod, to: targetUnit))
            }
            else {
                return nil
            }
        case .introductoryPriceMode, .introductoryPrice, .introductoryPriceDuration, .introductoryPriceDurationUnit:
            return formatIntroductionary(component: component, introductoryPrice: product.introductoryPrice)
        }
    }
    
    private func priceFormatter(locale: Locale) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        return formatter
    }
    
    private func formatIntroductionary(component: ProductComponent, introductoryPrice: SKProductDiscount?) -> String? {
        guard let introductoryPrice = introductoryPrice else {
            return nil
        }
        
        switch component {
        case .introductoryPriceMode:
            switch introductoryPrice.paymentMode {
            case .freeTrial:
                return "trial"
            case .payAsYouGo:
                return "pay as you go"
            case .payUpFront:
                return "upfront"
            @unknown default:
                return nil
            }
        case .introductoryPriceDurationUnit:
            return formatDurationUnit(introductoryPrice.subscriptionPeriod)
        case .introductoryPriceDuration:
            return formatDuration(introductoryPrice.subscriptionPeriod)
        case .introductoryPrice:
            return format(price: introductoryPrice.price, locale: introductoryPrice.priceLocale, period: introductoryPrice.subscriptionPeriod)
        default:
            return nil
        }
    }
    
    private func format(price: NSDecimalNumber, locale: Locale, period: SKProductSubscriptionPeriod?) -> String? {
        let formatter = priceFormatter(locale: locale)
        
        if priceFormatStyle == .noConversion {
            return formatter.string(from: price)
        }
        else if let targetUnit = priceFormatStyle.targetUnit, let period = period {
            // We must do a price converstion to the correct price.
            return formatter.string(from: convert(price: price, from: period, to: targetUnit))
        }
        else {
            return nil
        }
    }
    
    private func formatDuration(_ period: SKProductSubscriptionPeriod?) -> String? {
        guard let period = period else {
            return nil
        }
        
        let formattingUnit = priceFormatStyle.targetUnit ?? period.unit
                   
        var numberOfUnits = period.numberOfUnits

        if priceFormatStyle.targetUnit != nil {
            numberOfUnits = convert(numberOfUnits: numberOfUnits, from: period, to: formattingUnit)
        }
        
        // Handle quarter
        if numberOfUnits == 3 && period.unit == .month && convertToQuarter {
            numberOfUnits = 1
        }
        
        return "\(numberOfUnits)"
    }
    
    private func formatDurationUnit(_ period: SKProductSubscriptionPeriod) -> String? {
        let formattingUnit = priceFormatStyle.targetUnit ?? period.unit
        
        var numberOfUnits = period.numberOfUnits
        
        if priceFormatStyle.targetUnit != nil {
            numberOfUnits = convert(numberOfUnits: numberOfUnits, from: period, to: formattingUnit)
        }
        
        switch durationUnitFormatStyle {
        case .normal:
            if usePlural && durationUnitSeparator == nil {
                // Handle quarter specifically
                var unitString = formattingUnit.stringValue
                if numberOfUnits == 3 && period.unit == .month && priceFormatStyle.targetUnit == nil && convertToQuarter {
                    unitString = "quarter"
                }
                else {
                    unitString = unitString.pluralize(count: numberOfUnits)
                }
                return "\(durationUnitSeparator ?? "")\(unitString)"
            }
            else {
                var unitString = formattingUnit.stringValue
                
                if numberOfUnits == 3 && period.unit == .month && priceFormatStyle.targetUnit == nil && convertToQuarter {
                    unitString = "quarter"
                }
                
                return "\(durationUnitSeparator ?? "")\(unitString)"
            }
        case .short:
            return "\(durationUnitSeparator ?? "")\(formattingUnit.shortStringValue)"
        }
    }
    
    /// Convert price number from period unit to desired target unit.
    /// - Parameters:
    ///   - price: to be converted
    ///   - unit: unit price is currently in
    ///   - targetUnit: desired price unit
    /// - Returns: price
    private func convert(price: NSDecimalNumber, from period: SKProductSubscriptionPeriod, to targetUnit: SKProduct.PeriodUnit) -> NSDecimalNumber {
        // Convert to monthly price
        
        let singleUnitPrice = price.dividing(by: NSDecimalNumber(value: period.numberOfUnits))
        
        let monthlyPrice : NSDecimalNumber
        // First convert the price to monthly price, to work from same start.
        switch period.unit {
        case .day:
            monthlyPrice = singleUnitPrice.multiplying(by: NSDecimalNumber(floatLiteral: 30.0))
        case .week:
            monthlyPrice = singleUnitPrice.multiplying(by: NSDecimalNumber(floatLiteral: 4.0))
        case .year:
            monthlyPrice = singleUnitPrice.dividing(by: NSDecimalNumber(floatLiteral: 12.0))
        case .month:
            monthlyPrice = singleUnitPrice
        @unknown default:
            monthlyPrice = singleUnitPrice
        }
        
        switch targetUnit {
            case .day:
                return monthlyPrice.dividing(by: NSDecimalNumber(floatLiteral: 30.0))
            case .week:
                return monthlyPrice.dividing(by: NSDecimalNumber(floatLiteral: 4.0))
            case .year:
                return monthlyPrice.multiplying(by: NSDecimalNumber(floatLiteral: 12.0))
            case .month:
                return monthlyPrice
        @unknown default:
                return monthlyPrice
        }
    }
    
    private func convert(numberOfUnits: Int, from period: SKProductSubscriptionPeriod, to targetUnit: SKProduct.PeriodUnit) -> Int {
        
        let dailyNumberOfUnits : Int
        
        // First convert the price to monthly price, to work from same start.
        switch period.unit {
        case .day:
            dailyNumberOfUnits = numberOfUnits
        case .week:
            dailyNumberOfUnits = numberOfUnits * 7
        case .year:
            dailyNumberOfUnits = numberOfUnits * 365
        case .month:
            dailyNumberOfUnits = numberOfUnits * 30
        @unknown default:
            dailyNumberOfUnits = numberOfUnits * 30
        }
        
        switch targetUnit {
            case .day:
                return dailyNumberOfUnits
            case .week:
                return Int(Double(dailyNumberOfUnits) / 7.0)
            case .year:
                return Int(Double(dailyNumberOfUnits) / 365.0)
            case .month:
                return Int(Double(dailyNumberOfUnits) / 30.0)
        @unknown default:
                return dailyNumberOfUnits
        }
    }
}

public extension SKProduct.PeriodUnit {
    var stringValue : String {
        switch self {
        case .day:
            return "day"
        case .week:
            return "week"
        case .month:
            return "month"
        case .year:
            return "year"
        @unknown default:
            return ""
        }
    }
    
    var shortStringValue : String {
        switch self {
        case .day:
            return "dy"
        case .week:
            return "wk"
        case .month:
            return "mo"
        case .year:
            return "yr"
        @unknown default:
            return ""
        }
    }
}
