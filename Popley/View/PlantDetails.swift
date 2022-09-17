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
        VStack(alignment: .leading, spacing: 15) {
            Image(plant.picture)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .mask {
                    Rectangle()
                }
                .cornerRadius(10)
            Text("Needs water every ") +
            Text(String(describing: plant.waterInterval))
                .fontWeight(.semibold)
            Text("Next watering in ") +
            Text(String(describing: plant
                .timeToWater
                .asDescriptiveDateInterval
            ))
                .fontWeight(.bold)
            Spacer()
        }
        .navigationTitle(plant.name)
        .padding()
        
    }
}

struct PlantDetails_Previews: PreviewProvider {
    static var previews: some View {
        PlantDetails(plant: Plant.sampleData.last!)
    }
}
