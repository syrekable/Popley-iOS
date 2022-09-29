//
//  MockStorage.swift
//  Popley
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation

class MockStorage: KeyValueStorable {
    private var store: [String: Double]
    
    init() {
        store = [:]
    }
    
    func double(forKey: String) -> Double {
        return 4.2
    }
    
    func set(_: Double, forKey: String) {
        
    }
}
