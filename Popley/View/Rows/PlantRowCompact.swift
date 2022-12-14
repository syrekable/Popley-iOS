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
                .clipShape(Circle())
                // kinda even
                .overlay(Circle().stroke(Color("Secondary"), lineWidth: 4))
                .frame(height: 60)
            Text(plant.name)
                .font(.title)
                .fontWeight(.medium)
                .frame(maxWidth: 200, alignment: .center)
            Button {
                model.water(plant)
            } label: {
                Image(systemName: "drop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 62)
            }
        }
    }
}

struct PlantRowCompact_Previews: PreviewProvider {
    static var previews: some View {
        PlantRowCompact(plant: Plant.thirstyPlants.first!)
            .environmentObject(Model.withThirstyPlants())
            .previewLayout(.sizeThatFits)
    }
}
