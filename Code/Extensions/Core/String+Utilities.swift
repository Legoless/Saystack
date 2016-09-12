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
        
        let range = NSMakeRange(0, self.characters.count)
        
        return regex.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range:range, withTemplate: "")
    }
    
    public var html2AttributedString: NSAttributedString? {
        guard let data = data(using: String.Encoding.utf8) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:String.Encoding.utf8], documentAttributes: nil)
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
        
        if test == false {
            return false
        }
        
        //
        // A more complex test
        //
        
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            test = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
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
        
        return string.characters.index(string.startIndex, offsetBy: range.location)..<string.characters.index(string.startIndex, offsetBy: range.location + range.length)
    }

    // based on https://gist.github.com/samuel-mellert/20b3c99dec168255a046
	// which is based on https://gist.github.com/szhernovoy/276e69eb90a0de84dd90
	// Updated to work on Swift 2.2

	public static func random(_ length: Int = 20) -> String {
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
                if let data = data(using: String.Encoding.utf8) {
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: AnyObject]
                
                    return json
                }
                
                return nil
            }
            catch {
                return nil
            }
        }
    }
    
    public static func fromJSON(_ object: [String : AnyObject]) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions())
            
            return String(data: data, encoding: String.Encoding.utf8)
        }
        catch {
            return nil
        }
    }
}