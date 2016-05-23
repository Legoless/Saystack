//
//  String+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation
import UIKit

extension String {
    public func stripHTMLtags() -> String {
        let regex:NSRegularExpression = try! NSRegularExpression(pattern: "<.*?>", options: NSRegularExpressionOptions.CaseInsensitive)
        
        let range = NSMakeRange(0, self.characters.count)
        
        return regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range:range, withTemplate: "")
    }
    
    public var html2AttributedString: NSAttributedString? {
        guard let data = dataUsingEncoding(NSUTF8StringEncoding) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
        } catch {
            return nil
        }
    }

    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }

    public var isValidEmail : Bool {
        get {
            let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            
            return emailTest.evaluateWithObject(self)
        }
    }
    
    public func toStringRange(range: NSRange, string:String ) -> Range<String.Index>? {
        guard range.location != NSNotFound else {
            return nil
        }
        
        return string.startIndex.advancedBy(range.location)..<string.startIndex.advancedBy(range.location + range.length)
    }
    
    //
    // MARK: JSON utilities
    //
    
    public var JSONObject : [String : AnyObject]? {
        get {
            do {
                if let data = dataUsingEncoding(NSUTF8StringEncoding) {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions()) as? [String: AnyObject]
                
                    return json
                }
                
                return nil
            }
            catch {
                return nil
            }
        }
    }
    
    public static func fromJSON(object: [String : AnyObject]) -> String? {
        do {
            let data = try NSJSONSerialization.dataWithJSONObject(object, options: NSJSONWritingOptions())
            
            return String(data: data, encoding: NSUTF8StringEncoding)
        }
        catch {
            return nil
        }
    }
}
