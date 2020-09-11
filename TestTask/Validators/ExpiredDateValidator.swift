//
//  ExpiredDateValidator.swift
//  TestTask
//
//  Created by Ruslan on 11.09.2020.
//  Copyright © 2020 Palapa Ruslan. All rights reserved.
//

import Foundation

final class ExpiredDateValidator {
  
    private enum Constants {
        static let maxYear: Int = 30
        static let maxMonth: Int = 12
    }

    func isValid(_ value: String) -> Bool {
        let values = value.components(separatedBy: "/")
        guard values.count == 2, let month = Int(values.first ?? ""), let year = Int(values.last ?? ""), month <= Constants.maxMonth, year <= Constants.maxYear else { return false }
        return year > Date().year % 100 || (year == Date().year % 100 && month >= Date().month)
    }
    
}
