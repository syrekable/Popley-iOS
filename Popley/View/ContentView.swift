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
        NavigationStack(path: $model.path) {
            ScrollView {
                ZStack {
                    // FIXME: this is a hack
                    /*
                     List(Page.allCases) { page in
                         NavigationLink(value: page, label: {
                             AddNewPlantPagePresenterView(page: page)
                         })
                     }
                     */
                    //.opacity(0)
                    VStack {
                        ForEach(Plant.sampleData) { plant in
                            PlantRow(plant: plant,
                                     navigateToPlantDetailsAction: model.navigateToPlant)
                        }
                        .navigationDestination(for: Plant.self) { plant in
                            PlantDetails(plant: plant)
                        }
                        .navigationDestination(for: Page.self) { page in
                            AddNewPlantPagePresenterView(page: page)
                        }
                        .navigationTitle("Your plants")
                        .toolbar(content: {
                            Button {
                                model.navigateToNextStageOfAddingNewPlant()
                            } label: {
                                Label("add new plant", systemImage: "plus")
                            }
                        })
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
    }
}
