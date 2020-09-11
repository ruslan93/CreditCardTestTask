//
//  DateExtexsions.swift
//  TestTask
//
//  Created by Ruslan on 11.09.2020.
//  Copyright © 2020 Palapa Ruslan. All rights reserved.
//

import Foundation

extension Date {
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }

    var year: Int {
        Calendar.current.component(.year, from: self)
    }

}
