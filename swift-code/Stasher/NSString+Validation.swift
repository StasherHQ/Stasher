//  Converted with Swiftify v1.0.6292 - https://objectivec2swift.com/
//
//  NSString1.h
//  Stasher
//
//  Created by bhushan on 12/11/14.
//  Copyright (c) 2014 OAB. All rights reserved.
//
import Foundation
import UIKit
extension NSString {
    func validateNotEmpty() -> Bool {
        var characterSet = CharacterSet.whitespacesAndNewlines
        return (trimmingCharacters(in: characterSet).length != 0)
    }

    func validateMinimumLength(_ length: Int) -> Bool {
        return ((self.characters.count ?? 0) >= length)
    }

    func validateMaximumLength(_ length: Int) -> Bool {
        return ((self.characters.count ?? 0) <= length)
    }

    func validateMatchesConfirmation(_ confirmation: String) -> Bool {
        return (self == confirmation)
    }

    func validate(in characterSet: CharacterSet) -> Bool {
        return ((self as NSString).rangeOfCharacter(characterSet.inverted).location == NSNotFound)
    }

    func validateAlpha() -> Bool {
        return validate(in: CharacterSet.letters)
    }

    func validateAlphanumeric() -> Bool {
        return validate(in: CharacterSet.alphanumerics)
    }

    func validateNumeric() -> Bool {
        return validate(in: CharacterSet.decimalDigits)
    }

    func validateAlphaSpace() -> Bool {
        var characterSet = CharacterSet.letters
        characterSet.addCharacters(in: " ")
        return validate(in: characterSet)
    }

    func validateAlphanumericSpace() -> Bool {
        var characterSet = CharacterSet.alphanumerics
        characterSet.addCharacters(in: " ")
        return validate(in: characterSet)
    }

    func validateAlphanumericSpaceAndAt() -> Bool {
        var characterSet = CharacterSet.alphanumerics
        characterSet.addCharacters(in: " ")
        characterSet.addCharacters(in: "@")
        return validate(in: characterSet)
    }

    func validateUsername() -> Bool {
        var characterSet = CharacterSet.alphanumerics
        characterSet.addCharacters(in: "'_.")
        return validate(in: characterSet)
    }

    func validateEmail() -> Bool {
        var regex: String = "\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
        var regextest = NSPredicate(format: "SELF MATCHES %@", regex)
        return regextest.evaluate(withObject: self)
    }

    func validatePhoneNumber() -> Bool {
        var characterSet = CharacterSet.decimalDigits
        characterSet.addCharacters(in: "'-*+#,;. ")
        return validate(in: characterSet)
    }

    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    //--------------------------------------------------------------
    // Alphanumeric characters, underscore (_), and period (.)
    //--------------------------------------------------------------
    // http://stackoverflow.com/questions/3139619/check-that-an-email-address-is-valid-on-ios
    // http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    //--------------------------------------------------------------
}