//
//  NotificationSettings.swift
//  Popley
//
//  Created by Jordan Niedzielski on 28/09/2022.
//

import Foundation

struct NotificationSettings {
    // FIXME: too broad/vague name
    var time: DateComponents
}

// MARK: convenience enum
extension NotificationSettings {
    enum TimeOfDay: Int, CaseIterable, Identifiable {
        var id: TimeOfDay { self }
        case morning = 8
        case evening = 18
    }
}

// MARK: description
extension NotificationSettings.TimeOfDay: CustomStringConvertible {
    var description: String {
        var _description: String?
        switch self {
        case .morning:
            _description = "Morning"
        case .evening:
            _description = "Evening"
        }
        return _description!
    }
}

// MARK: conversion and distance
extension NotificationSettings.TimeOfDay {
    var asDateComponents: DateComponents {
        return DateComponents(hour: self.rawValue, minute: 0)
    }
    
    private static let morningHours: ClosedRange<DateComponents> = DateComponents(hour: 00, minute: 00)...DateComponents(hour: 15, minute: 00)
    
    static func appropriateTimeOfDay(for time: DateComponents) -> Self {
        var timeOfDay: Self?
        if morningHours.contains(time) {
            timeOfDay = .morning
        } else {
            timeOfDay = .evening
        }
        return timeOfDay!
    }
}
