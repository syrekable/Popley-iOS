//
//  TypeDescriptionTests.swift
//  PopleyTests
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import Foundation

import XCTest
@testable import Popley

final class TypeDescriptionTests: XCTestCase {

    /*
     func testExample() throws {
         // This is an example of a functional test case.
         // Use XCTAssert and related functions to verify your tests produce the correct results.
         // Any test you write for XCTest can be annotated as throws and async.
         // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
         // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
     }
     */
    
    
    func testWaterIntervalSingularDescription() {
        let interval = DescriptiveDateInterval(frequency: 1, interval: .month)
        
        XCTAssertEqual(String(describing: interval), "1 month")
    }
    
    func testWaterIntervalPluralDescription() {
        let interval = DescriptiveDateInterval(frequency: 2, interval: .week)
        
        XCTAssertEqual(String(describing: interval), "2 weeks")
    }
}
