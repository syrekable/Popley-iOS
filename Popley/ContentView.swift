//
//  ContentView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        /*
         TODO:
         - only the gear icon navigates to plant's details/edit
         - editability of Plant's data
         - background colour for the whole app
         */
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(Plant.sampleData) { plant in
                        NavigationLink(value: plant) {
                            PlantRow(name: plant.name, timeToWater: plant.waterInterval, imageName: plant.picture, waterAction: {})
                        }
                    }
                    .navigationDestination(for: Plant.self) { plant in
                        PlantDetails(plant: plant)
                    }
                    .navigationTitle("Your plants")
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
