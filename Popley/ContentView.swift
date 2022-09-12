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
         - navigation to detail views
         - actual detail views
         - figuring out if cog or default nav chevron works
         - editability of Plant's data
         - background colour for the whole app
         */
        NavigationView {
            List {
                ForEach(Plant.sampleData) { plant in
                    PlantCardView(name: plant.name, timeToWater: plant.waterInterval, imageName: plant.picture)
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
