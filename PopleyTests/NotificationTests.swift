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
    /// Convenience wrapper over notification testing logic.
    ///
    /// This function:
    /// * asserts that there are requests
    /// * asserts count of the requests is equal to `desired`
    /// * checks if the trigger(s) created succesfully
    /// * checks if the date (expressed as `TimeInterval`) is in accurate enough
    static func doTest(notificationManager: NotificationManaging, expected: Date, desired count: Int = 1) {
        notificationManager.getPendingNotificationRequests { requests in
            XCTAssert(!requests.isEmpty)
            XCTAssertEqual(requests.count, count)
            if requests.count == count {
                let trigger = requests.first!.trigger
                XCTAssertNotNil(trigger)
                guard let trigger = trigger as? UNTimeIntervalNotificationTrigger else { return }
                let now = Date()
                XCTAssertEqual(now.distance(to: trigger.nextTriggerDate()!),
                               now.distance(to: expected),
                               accuracy: 0.1)
                
            }
        }
    }
    
    func testSetCorrectTimeAsTriggerForNewPlantWithConvenience() {
        let storage = MockStorage.withMorningNotificationTime()
        let notificationManager = MockNotificationCenter()
        let model = Model(readFrom: storage)
        
        let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: Date())
        
        let storedNotificationTime = storage.double(forKey: AppSettingsViewModel.userDefaultsKeys["time"]!)
        let expectedNextTriggerDate = Date(timeIntervalSince1970: plant.timeToWater.duration)
            .addingTimeInterval(storedNotificationTime)
        model.addPlant(plant, notificationManager: notificationManager)
        
        Self.doTest(notificationManager: notificationManager, expected: expectedNextTriggerDate)
    }
    
    func testEveryThreeDaysTriggerWithSpecificHour() {
        let storage = MockStorage.withSpecificNotificationTime()
        let notificationManager = MockNotificationCenter()
        let model = Model(readFrom: storage)
        
        let plant = Plant(waterInterval: WaterInterval(days: 3)!)
        
        let storedNotificationTime = storage.double(forKey: AppSettingsViewModel.userDefaultsKeys["time"]!)
        let expectedNextTriggerDate = Date(timeIntervalSince1970: plant.timeToWater.duration)
            .addingTimeInterval(storedNotificationTime)
        
        model.addPlant(plant, notificationManager: notificationManager)
        
        Self.doTest(notificationManager: notificationManager, expected: expectedNextTriggerDate)
    }
    
    func testEveryTwoWeeksTriggerWithConvenience() {
        let storage = MockStorage.withMorningNotificationTime()
        let notificationManager = MockNotificationCenter()
        let model = Model(readFrom: storage)
        
        let plant = Plant(waterInterval: WaterInterval(frequency: 3, interval: .week))
        
        // since I'm here...
        XCTAssertEqual(WaterInterval(days: 21), plant.waterInterval)
        
        let storedNotificationTime = storage.double(forKey: AppSettingsViewModel.userDefaultsKeys["time"]!)
        let expectedNextTriggerDate = Date(timeIntervalSince1970: plant.timeToWater.duration)
            .addingTimeInterval(storedNotificationTime)
        
        model.addPlant(plant, notificationManager: notificationManager)
        
        Self.doTest(notificationManager: notificationManager, expected: expectedNextTriggerDate)
    }
    
    func testEveryTwoMonthsTriggerWithSpecificHour() {
        let storage = MockStorage.withSpecificNotificationTime()
        let notificationManager = MockNotificationCenter()
        let model = Model(readFrom: storage)
        
        let plant = Plant(waterInterval: WaterInterval(frequency: 2, interval: .month))
        
        let storedNotificationTime = storage.double(forKey: AppSettingsViewModel.userDefaultsKeys["time"]!)
        let expectedNextTriggerDate = Date(timeIntervalSince1970: plant.timeToWater.duration)
            .addingTimeInterval(storedNotificationTime)
        
        model.addPlant(plant, notificationManager: notificationManager)
        
        Self.doTest(notificationManager: notificationManager, expected: expectedNextTriggerDate)
    }
    
    // THIS TEST WILL NOT SUCCEED IF YOU TRY TO RUN IT AFTER 21:37
    /*
     // don't know how to put it in the test language, but the trigger.nextTriggerDate is correct
     func testHackingNotificationForTheSameDay() {
         let storage = MockStorage.withSpecificNotificationTime()
         let storedNotificationTime = storage.double(forKey: AppSettingsViewModel.userDefaultsKeys["time"]!)
         let notificationManager = MockNotificationCenter()
         let model = Model(readFrom: storage)
         
         let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: Date() - 1.day.timeInterval)
        
     // how to express 'today at a specific hour'? lol
         let expectedNextTriggerDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + storedNotificationTime)
         
         model.addPlant(plant, notificationManager: notificationManager)
         
         Self.doTest(notificationManager: notificationManager, expected: expectedNextTriggerDate)
     }
     */

}
