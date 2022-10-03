//
//  NotificationManaging.swift
//  Popley
//
//  Created by Jordan Niedzielski on 30/09/2022.
//

import Foundation
import UserNotifications

protocol NotificationManaging {
    func add(_: UNNotificationRequest, withCompletionHandler: ((Error?) -> Void)?)
    func getPendingNotificationRequests(completionHandler: @escaping ([UNNotificationRequest]) -> Void)
}
