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
    
    enum TimeOfNotification: String, CaseIterable, Identifiable {
        var id: TimeOfNotification { self }
        case morning, evening
    }
}
