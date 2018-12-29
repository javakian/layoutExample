//  RegularExpression.swift
//  Interface
//
//  Created by CHH51 on 12/28/18.

import Foundation

extension NSRegularExpression {
    
    /// Does preconditionFailure() if invalid RegularExpression pattern
    ///
    /// see https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift
    /// - Parameter pattern_: Regular expression pattern
    public convenience init(_ pattern_: String ) {
        do {
            try self.init( pattern: pattern_ )
        } catch {
            preconditionFailure("Illegal regular expression \(pattern_)")
        }
    }
    
    /// Does the string match the NSRegularExpression
    ///
    /// see https://www.hackingwithswift.com/articles/108/how-to-use-regular-expressions-in-swift
    /// - Parameter string_: string to test
    /// - Returns:  true if match, else false
    public func matches(_ string_: String ) -> Bool {
        let range = NSRange(location: 0, length: string_.utf16.count )
        return firstMatch(in: string_, options: [], range: range ) != nil
    }
}
