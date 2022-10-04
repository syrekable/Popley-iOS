//
//  PlantRowCompact.swift
//  Popley
//
//  Created by Jordan Niedzielski on 04/10/2022.
//

import SwiftUI

struct PlantRowCompact: View {
    @EnvironmentObject var model: Model
    let plant: Plant
    var body: some View {
        HStack {
            Image(uiImage: plant.imageWrapper.image)
                .resizable()
                .scaledToFit()
                .mask {
                    Circle()
                }
                .frame(height: 125/2)
            
            Text(plant.name)
                .font(.title)
                .fontWeight(.medium)
                .frame(maxWidth: 200, alignment: .center)
            Button {
                //plant.water()
            } label: {
                Image(systemName: "drop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 125/2)
            }
        }
        .padding()
    }
}

struct PlantRowCompact_Previews: PreviewProvider {
    static var previews: some View {
        PlantRowCompact(plant: Plant.thirstyPlants.first!)
            .environmentObject(Model.withThirstyPlants())
            .previewLayout(.sizeThatFits)
    }
}
