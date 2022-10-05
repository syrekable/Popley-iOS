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
    private static func doSortingTest(for model: Model, order: SortingOption, expecting expected: [Plant]) {
        model.sorting = order
        XCTAssertEqual(model.sortedPlants, expected)
    }
    /*
     func testShowingThirstyPlants() {
         let model = Model.withThirstyPlants()
         // test fails when the check is executed on main thread, interesting!
         model.checkForThirstyPlants()
         
         XCTAssertTrue(model.isShowingThirstyPlants)
     }
     */
    
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
    
    func testSortingByNameAscending() {
        let model = Model.withWateredPlants()
        let expected = Plant.sampleData.sorted { a, b in
            a.name < b.name
        }
        
        Self.doSortingTest(for: model, order: .byName(.ascending), expecting: expected)
    }
    
    func testSortingByNameDescending() {
        let model = Model.withWateredPlants()
        let expected = Plant.sampleData.sorted { a, b in
            a.name > b.name
        }
        
        Self.doSortingTest(for: model, order: .byName(.descending), expecting: expected)
    }
    
    func testSortingByTimeToWaterAscending() {
        let model = Model.withWateredPlants()
        let expected = Plant.sampleData.sorted { a, b in
            a.timeToWater < b.timeToWater
        }
        
        Self.doSortingTest(for: model, order: .byTimeToWater(.ascending), expecting: expected)
    }
    
    func testSortingByTimeToWaterDescending() {
        let model = Model.withWateredPlants()
        let expected = Plant.sampleData.sorted { a, b in
            a.timeToWater > b.timeToWater
        }
        
        Self.doSortingTest(for: model, order: .byTimeToWater(.descending), expecting: expected)
    }
    
    func testSortingByLastWaterDateAscending() {
        let model = Model.withWateredPlants()
        let expected = Plant.sampleData.sorted { a, b in
            a.lastWaterDate < b.lastWaterDate
        }
        
        Self.doSortingTest(for: model, order: .byLastWaterDate(.ascending), expecting: expected)
    }
    
    func testSortingByLastWaterDateDescending() {
        let model = Model.withWateredPlants()
        let expected = Plant.sampleData.sorted { a, b in
            a.lastWaterDate > b.lastWaterDate
        }
        
        Self.doSortingTest(for: model, order: .byLastWaterDate(.descending), expecting: expected)
    }
}
