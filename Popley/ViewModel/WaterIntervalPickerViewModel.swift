//
//  WaterIntervalPickerViewModel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 03/10/2022.
//

import Foundation
import Datez

class WaterIntervalPickerViewModel: ObservableObject {
    /// Returns the range from `days` back to `endDate`.
    static func makeDateRange(from endDate: Date, for days: Int) -> ClosedRange<Date> {
        return (Date() - (days-1).day.timeInterval)...Date()
    }
}
