//
//  Utils.swift
//  PT FDS Albert
//
//  Created by Albert on 11/1/21.
//

import Foundation

struct Utils {
    public static func currentAge(birthDate: String, dateFormat: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormat
        let bday = dateFormater.date(from: birthDate) ?? Date()
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let calcAge = calendar.components(.year, from: bday, to: Date(), options: [])
        let age = calcAge.year
        return age ?? -1
    }
}

