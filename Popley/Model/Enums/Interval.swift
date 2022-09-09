//
//  Interval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

enum Interval: String, CaseIterable {
    case day, week, month
    
    static var allCases: [Interval] {
        [.day, .week, .month]
    }
}

/*
 extension Interval: CustomStringConvertible {
     var description: String {
         self.rawValue.capitalized
     }
 }
 */

