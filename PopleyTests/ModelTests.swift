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
}
