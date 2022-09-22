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
            Image(uiImage: plant.picture)
                .resizable()
                .scaledToFill()
                .frame(height: 300)
                .mask {
                    Rectangle()
                }
                .cornerRadius(10)
            HStack {
                Label("Needs water every:", systemImage: "calendar.circle")
                Spacer()
                Text(String(describing: plant.waterInterval))
                    .fontWeight(.semibold)
            }
            HStack {
                Label("Next watering in:", systemImage: "timer")
                Spacer()
                Text(String(describing: plant
                    .timeToWater
                    .asDescriptiveDateInterval
                ))
                    .fontWeight(.semibold)
            }
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
