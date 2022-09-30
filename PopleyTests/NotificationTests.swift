//
//  NotificationTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 30/09/2022.
//
import XCTest
import Datez
@testable import Popley

final class NotificationTests: XCTestCase {
    func testCorrectTimeSetAsTriggerForNewPlant() {
        let storage = MockStorage.withMorningNotificationHour()
        let notificationManager = MockNotificationCenter()
        let model = Model()
        let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: Date())
        
        model.addPlant(plant, notificationManager: notificationManager)
        
        notificationManager.getPendingNotificationRequests { requests in
            XCTAssert(!requests.isEmpty)
        }
    }
}
