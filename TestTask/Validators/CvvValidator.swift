//
//  CvvValidator.swift
//  TestTask
//
//  Created by Ruslan on 11.09.2020.
//  Copyright © 2020 Palapa Ruslan. All rights reserved.
//

import Foundation

final class CvvValidator {

    private enum Constants {
        static let cvvLenght: Int = 3
    }

    func isValid(_ value: String) -> Bool {
        value.count == Constants.cvvLenght
    }
    
}
