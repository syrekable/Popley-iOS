//
//  ContentView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    @State private var isAddingNewPlant: Bool = false
    var body: some View {
        /*
         TODO:
         - editability of Plant's data
         - background colour for the whole app
         */
        NavigationStack(path: $model.plants) {
            ScrollView {
                VStack {
                    ForEach(Plant.sampleData) { plant in
                        PlantRow(plant: plant,
                                 navigateToPlantDetailsAction: model.navigateToPlant)
                    }
                    .navigationDestination(for: Plant.self) { plant in
                        PlantDetails(plant: plant)
                    }
                    .navigationTitle("Your plants")
                    .toolbar(content: {
                        Button {
                            isAddingNewPlant = true
                        } label: {
                            Label("add new plant", systemImage: "plus")
                        }
                    })
                }
            }
        }
        .sheet(isPresented: $isAddingNewPlant) {
            AddNewPlantView(model: AddNewPlantViewModel())
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
