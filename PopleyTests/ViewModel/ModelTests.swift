//
//  ModelTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 04/10/2022.
//

import XCTest
import Datez
@testable import Popley

final class ModelTests: XCTestCase {
    func testShowingThirstyPlants() {
        let model = Model.withThirstyPlants()
        model.checkForThirstyPlants()
        
        XCTAssertTrue(model.isShowingThirstyPlants)
    }
    
    func testShowingWateredPlants() {
        let model = Model.withWateredPlants()
        model.checkForThirstyPlants()
        
        XCTAssertFalse(model.isShowingThirstyPlants)
    }
    
    func testWateringAndSchedulingNextReminderForPlant() {
        let storage = MockStorage.withSpecificNotificationTime()
        let center = MockNotificationCenter()
        let model = Model.withThirstyPlants(readFrom: storage)
        let notificationTime = storage.double(forKey: AppSettingsViewModel.userDefaultsKeys["time"]!)
        
        let plant = model.plants.randomElement()!
        
        model.water(plant, notificationManager: center)
        
        // as a the plant is effectively replaced, I have to find it again
        let newPlant = model.plants.first(where: { $0.id == plant.id })!
        // probably could've declared it in a simpler manner
        let expectedReminderDate = Date() + newPlant.waterInterval.asTimeInterval + (notificationTime - Date().timeIntervalSince1970)
        
        // plant.lastWaterDate
        XCTAssertEqual(newPlant.lastWaterDate.timeIntervalSince1970, Date().timeIntervalSince1970, accuracy: 0.1)
        // plant.timeToWater
        XCTAssertEqual(newPlant.timeToWater.duration, newPlant.waterInterval.asTimeInterval)
        NotificationTests.doTest(notificationManager: center, expected: expectedReminderDate)
    }
}
