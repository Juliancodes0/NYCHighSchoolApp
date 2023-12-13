//
//  String.swift
//  NYCHighSchoolApp
//
//  Created by Julian Burton on 12/13/23.
//

import Foundation

extension String {
    func containsOnlyNumbers () -> Bool {
        let numericRegex = "^[0-9]+$"
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: numericRegex)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
