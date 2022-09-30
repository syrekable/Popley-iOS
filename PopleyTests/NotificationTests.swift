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
        let storage = MockStorage()
        
        
        let model = Model()
        
        let plant = Plant(waterInterval: WaterInterval(), lastWaterDate: Date())
    }
}
