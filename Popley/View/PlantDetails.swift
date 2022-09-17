//
//  PlantDetails.swift
//  Popley
//
//  Created by Jordan Niedzielski on 12/09/2022.
//

import SwiftUI

struct PlantDetails: View {
    let plant: Plant
    var body: some View {
        VStack {
            Text(plant.name)
        }
    }
}

struct PlantDetails_Previews: PreviewProvider {
    static var previews: some View {
        PlantDetails(plant: Plant.sampleData.last!)
    }
}
