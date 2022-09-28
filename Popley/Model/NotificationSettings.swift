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
    enum TimeOfNotification: Int, CaseIterable, Identifiable {
        var id: TimeOfNotification { self }
        case morning = 8
        case evening = 18
    }
}

extension NotificationSettings.TimeOfNotification: CustomStringConvertible {
    var asDateComponents: DateComponents {
        return DateComponents(hour: self.rawValue, minute: 0)
    }
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
