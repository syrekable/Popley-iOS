//
//  Interval.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

/// Enum for working with seleted intervals - days, weeks and months.
enum Interval: String, CaseIterable, Hashable, Codable {
    case day, week, month
}
