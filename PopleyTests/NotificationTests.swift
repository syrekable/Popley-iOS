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
    func testSetCorrectTimeAsTriggerForNewPlantWithConvenience() {
        let storage = MockStorage.withMorningNotificationTime()
        let notificationManager = MockNotificationCenter()
        let model = Model(readFrom: storage)
        
        let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: Date())
        let expectedNextTriggerDate = Date(timeIntervalSince1970: plant.timeToWater.duration)
            .addingTimeInterval(
                storage
                    .double(
                        forKey: AppSettingsViewModel.userDefaultsKeys["time"]!
                              ))
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
    
    // TODO: test different hours
    /*
     func testSetCorrectTimeAsTriggerForNewPlantWithCustomTime() {
         let storage = MockStorage.withCustomNotificationTime()
         let notificationManager = MockNotificationCenter()
         let model = Model(readFrom: storage)
         
         let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: Date())
         // dunno how to set up the test condition, but the system does what it needs to do lol
         let expectedNextTriggerDate = Date(timeIntervalSince1970: plant.timeToWater.duration)
             .addingTimeInterval(DateComponents(hour: 21, minute: 37).asDateWithHoursAndMinutes!.timeIntervalSince(Date()))
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

     */
}
