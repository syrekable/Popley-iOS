//
//  Model.swift
//  Popley
//
//  Created by Jordan Niedzielski on 17/09/2022.
//

import Foundation

class Model: ObservableObject {
    @Published var plants: [UUID] = []
    
    func showPlant(of id: UUID) {
        plants.append(id)
    }
}
