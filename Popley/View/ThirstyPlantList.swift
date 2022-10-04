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
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("These are the plants that require your immediate attention.")
                        HStack {
                            Text("Mark each as watered by clicking")
                            Image(systemName: "drop.circle").foregroundColor(.accentColor)
                        }
                    }
                    VStack {
                        ForEach(model.thirstyPlants) { plant in
                            PlantRowCompact(plant: plant)
                        }
                    }
                }.padding([.horizontal])
                    
            }
            .navigationTitle("Plants to water")
            .onChange(of: model.thirstyPlants.count) { newValue in
                model.checkForThirstyPlants()
            }
        }
    }
}

struct ThirstyPlantList_Previews: PreviewProvider {
    static var previews: some View {
        ThirstyPlantList()
            .environmentObject(Model.withThirstyPlants())
    }
}
