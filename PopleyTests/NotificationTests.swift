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
        let model = Model(readFrom: storage)
        
        let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: Date())
        let expectedNextTriggerDate = Date(timeIntervalSince1970: plant.timeToWater.duration)
            .addingTimeInterval(
                storage
                    .double(
                        forKey: AppSettingsViewModel.userDefaultsKeys["time"]!
                              ))
        
        //print(expectedNextTriggerDate)
        // DateComponents.date
        
        model.addPlant(plant, notificationManager: notificationManager)
        
        notificationManager.getPendingNotificationRequests { requests in
            XCTAssert(!requests.isEmpty)
            XCTAssertEqual(requests.count, 1)
            if requests.count == 1 {
                let trigger = requests.first!.trigger
                XCTAssertNotNil(trigger)
                guard let trigger = trigger as? UNCalendarNotificationTrigger else { return }
                XCTAssertEqual(trigger.nextTriggerDate(), expectedNextTriggerDate)
            }
        }
    }
}
