//
//  String+Utilities.swift
//  Saystack
//
//  Created by Dal Rupnik on 23/05/16.
//  Copyright © 2016 Unified Sense. All rights reserved.
//

import Foundation
#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

extension String {
    public func stripHTMLtags() -> String {
        let regex:NSRegularExpression = try! NSRegularExpression(pattern: "<.*?>", options: NSRegularExpression.Options.caseInsensitive)
        
        let range = NSMakeRange(0, self.count)
        
        return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:range, withTemplate: "")
    }
    
    public var html2AttributedString: NSAttributedString? {
        guard let data = data(using: String.Encoding.utf8) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data, options: [ .documentType : NSAttributedString.DocumentType.html, .characterEncoding : String.Encoding.utf8], documentAttributes: nil)
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
        
        var test = emailTest.evaluate(with: self)
        
        if !test {
            return false
        }
        
        //
        // A more complex test
        //
        
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            test = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        }
        catch {
            return false
        }
        
        //
        // Edge cases
        //
        
        if self.contains("..") {
            return false
        }
        if self.hasPrefix(".") {
            return false
        }
        if self.contains(".@") {
            return false
        }
        if self.contains("@.") {
            return false
        }
        if self.contains("-@") {
            return false
        }
        if self.contains("@-") {
            return false
        }
        
        return true
    }
    
    public func toStringRange(_ range: NSRange, string:String ) -> Range<String.Index>? {
        guard range.location != NSNotFound else {
            return nil
        }
        
        return string.index(string.startIndex, offsetBy: range.location)..<string.index(string.startIndex, offsetBy: range.location + range.length)
    }
    
    
    ///
    /// Returns English noun's possession: eg.: John -> John's, Lucas -> Lucas', based on:
    /// http://dictionary.cambridge.org/grammar/british-grammar/determiners/possession-john-s-car-a-friend-of-mine
    ///
    /// - Returns: noun in possession's form
    ///
    public func possession () -> String {
        if hasSuffix("s") {
            return self + "'"
        }
        
        return self + "'s"
    }

    // based on https://gist.github.com/samuel-mellert/20b3c99dec168255a046
	// which is based on https://gist.github.com/szhernovoy/276e69eb90a0de84dd90
	// Updated to work on Swift 4

	public static func random(length: Int = 20) -> String {
		let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
		let charactersArray : [Character] = Array(charactersString)
        
        let count = UInt32(charactersString.count)

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
    
    public var JSONObject : Any? {
        get {
            do {
                if let data = data(using: String.Encoding.utf8) {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                
                    return json
                }
                
                return nil
            }
            catch {
                return nil
            }
        }
    }
    
    public static func fromJSON(object: Any) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions())
            
            return String(data: data, encoding: String.Encoding.utf8)
        }
        catch {
            return nil
        }
    }
}
