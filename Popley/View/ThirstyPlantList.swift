//
//  ThirstyPlantList.swift
//  Popley
//
//  Created by Jordan Niedzielski on 04/10/2022.
//

import SwiftUI

struct ThirstyPlantList: View {
    @EnvironmentObject var model: Model
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    instructions
                        ForEach(model.thirstyPlants) { plant in
                            PlantRowCompact(plant: plant)
                        }
                }.padding([.horizontal])
            }
            .navigationTitle("Plants to water")
        }
    }
}

struct ThirstyPlantList_Previews: PreviewProvider {
    static var previews: some View {
        ThirstyPlantList()
            .environmentObject(Model.withThirstyPlants())
    }
}

extension ThirstyPlantList {
    var instructions: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("These are the plants that require your immediate attention. ") +
                Text("Grab a bottle or a watering can and water them!")
                    .fontWeight(.bold)
                HStack {
                    Text("Then, mark each as watered by clicking")
                    Image(systemName: "drop.circle")
                        .foregroundColor(.accentColor)
                }
            }
            Spacer()
        }
    }
}
