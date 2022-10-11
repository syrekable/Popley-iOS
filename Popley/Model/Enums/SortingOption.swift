//
//  SortingOption.swift
//  Popley
//
//  Created by Jordan Niedzielski on 05/10/2022.
//

import Foundation

enum SortingOption {
    case byName(Order), byTimeToWater(Order), byLastWaterDate(Order)
    
    enum Order: String {
        case ascending, descending
    }
}

/*
 an enum with associated values can easily conform to the
 Identifiable protocol by using the Hashable protocol,
 provided your associated values are Hashable themselves
 (And since Order: String and String: Hashable -> Order: Hashable)
 https://sowenjub.me/writes/identifiable-enum-with-associated-values/
 */
extension SortingOption: Hashable, Identifiable {
    var id: Self { self }
}

extension SortingOption: CaseIterable {
    // TODO: can't it be done 'automagically'
    static var allCases: [SortingOption] = [
        byName(.ascending),
        byName(.descending),
        byTimeToWater(.ascending),
        byTimeToWater(.descending),
        byLastWaterDate(.ascending),
        byLastWaterDate(.descending)
    ]
}

extension SortingOption: CustomStringConvertible {
    var description: String {
        var _description: String?
        switch self {
        case .byName(let order):
            _description = "By name, \(order.rawValue)"
        case .byTimeToWater(let order):
            _description = "By time to water, \(order.rawValue)"
        case .byLastWaterDate(let order):
            _description = "By last watering date, \(order.rawValue)"
        }
        return _description!
    }
}
