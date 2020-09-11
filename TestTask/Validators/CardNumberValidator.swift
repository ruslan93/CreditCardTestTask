//
//  CardNumberValidator.swift
//  TestTask
//
//  Created by Ruslan on 11.09.2020.
//  Copyright © 2020 Palapa Ruslan. All rights reserved.
//

import Foundation

final class CardNumberValidator {
   
    private enum Constants {
        static let numberLenght: Int = 16
    }

    func isValid(_ value: String) -> Bool {
        value.count == Constants.numberLenght
    }
}
