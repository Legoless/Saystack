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
        //
        // First a simple test
        //
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        var test = emailTest.evaluateWithObject(self)
        
        if test == false {
            return false
        }
        
        //
        // A more complex test
        //
        
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .CaseInsensitive)
            test = regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        }
        catch {
            return false
        }
        
        //
        // Edge cases
        //
        
        if self.containsString("..") {
            return false
        }
        if self.hasPrefix(".") {
            return false
        }
        if self.containsString(".@") {
            return false
        }
        if self.containsString("@.") {
            return false
        }
        if self.containsString("-@") {
            return false
        }
        if self.containsString("@-") {
            return false
        }
        
        return true
    }
    
    public func toStringRange(range: NSRange, string:String ) -> Range<String.Index>? {
        guard range.location != NSNotFound else {
            return nil
        }
        
        return string.startIndex.advancedBy(range.location)..<string.startIndex.advancedBy(range.location + range.length)
    }

    // based on https://gist.github.com/samuel-mellert/20b3c99dec168255a046
	// which is based on https://gist.github.com/szhernovoy/276e69eb90a0de84dd90
	// Updated to work on Swift 2.2

	public static func random(length: Int = 20) -> String {
		let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		let charactersArray : [Character] = Array(charactersString.characters)
        
        let count = UInt32(charactersArray.count)

		var string = ""
		for _ in 0..<length {
            let rand = Int(arc4random_uniform(count))
            
		    string.append(charactersArray[rand])
		}

		return string
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
