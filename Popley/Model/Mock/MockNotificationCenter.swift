//
//  MockNotificationCenter.swift
//  Popley
//
//  Created by Jordan Niedzielski on 30/09/2022.
//

import Foundation
import UserNotifications

/// A simple UNNotificationCenter mock, used to test adding and deleting notification requests
class MockNotificationCenter: NotificationManaging {
    private var store: [UNNotificationRequest] = []
    
    func add(_ request: UNNotificationRequest, withCompletionHandler completion: ((Error?) -> Void)?) {
        store.append(request)
    }
    
    func getPendingNotificationRequests(completionHandler: @escaping ([UNNotificationRequest]) -> Void) {
        completionHandler(store)
    }
}
