//
//  Date.swift
//  Popley
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation

extension Date {
    // https://stackoverflow.com/a/62441255/12938809 - DateComponents from Date
    var asDateComponents: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute], from: self)
    }
}
