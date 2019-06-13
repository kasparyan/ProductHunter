//
//  Date+Extensions.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

extension Date {
    func stringFromDate() -> String {
        let fileFormatter = DateFormatter()
        fileFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        fileFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        fileFormatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone?
        return fileFormatter.string(from: self)
    }
}
