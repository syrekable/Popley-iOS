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
            // FIXME: arbitrary scale that looks like shit on bigger screens
                .frame(width: 360, height: 300)
                .mask {
                    Rectangle()
                }
                .cornerRadius(10)
            WaterIntervalLabel(description: "Needs water every:", iconName: "calendar.circle", intervalDescription: String(describing: plant.waterInterval))
            WaterIntervalLabel(description: "Next watering in:", iconName: "timer", intervalDescription: String(describing: plant
                .timeToWater
                .asDescriptiveDateInterval
            ))
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
