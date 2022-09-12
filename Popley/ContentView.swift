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
         - making use of Grid to display the PlantRow
         - figuring out if cog or default nav chevron works
         - editability of Plant's data
         - background colour for the whole app
         */
        NavigationStack {
            List(Plant.sampleData) { plant in
                NavigationLink(value: plant) {
                    PlantRow(name: plant.name, timeToWater: plant.waterInterval, imageName: plant.picture)
                }
            }
            .navigationDestination(for: Plant.self) { plant in
                PlantDetails(plant: plant)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
