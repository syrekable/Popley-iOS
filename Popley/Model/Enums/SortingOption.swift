//
//  SortingOption.swift
//  Popley
//
//  Created by Jordan Niedzielski on 05/10/2022.
//

import Foundation

enum SortingOption {
    case byName(Order), byTimeToWater(Order), byLastWaterDate(Order)
    
    enum Order {
        case ascending, descending
    }
}
