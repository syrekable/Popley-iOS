//
//  Model.swift
//  Popley
//
//  Created by Jordan Niedzielski on 17/09/2022.
//

import Foundation

class Model: ObservableObject {
    @Published var plants: [Plant] = []
    
    func showPlant(_ plant: Plant) {
        plants.append(plant)
    }
}
