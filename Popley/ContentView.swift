//
//  ContentView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            ForEach(Plant.sampleData) { plant in
                PlantCardView(name: plant.name, timeToWater: plant.waterInterval, imageName: plant.picture)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
