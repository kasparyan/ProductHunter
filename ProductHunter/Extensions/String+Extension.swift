//
//  String+Extension.swift
//  ProductHunter
//
//  Created by User on 6/12/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

extension String {
    func dateFromString() -> Date {
        let fileFormatter = DateFormatter()
        fileFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        fileFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        fileFormatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone?
        if let value = fileFormatter.date(from: self) {
            return value
        }
        return Date()
    }
}
