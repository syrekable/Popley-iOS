//
//  ContentView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var addPlantViewModel: AddPlantViewModel
    @State private var isAddingNewPlant: Bool = false
    var body: some View {
        /*
         TODO:
         - editability of Plant's data
         - background colour for the whole app
         */
        NavigationStack(path: $model.path) {
            ScrollView {
                VStack {
                    // TODO: sorting
                    ForEach(model.plants.reversed()) { plant in
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
                        Menu {
                            Button {
                                addPlantViewModel.source = .camera
                                model.navigateToNextStageOfAddingNewPlant()
                             } label: {
                                 Label("Take a photo", systemImage: "camera")
                             }
                                // TODO: enable
                                .disabled(true)
                             Button {
                                 addPlantViewModel.source = .library
                                 model.navigateToNextStageOfAddingNewPlant()
                             } label: {
                                 Label("Pick existing", systemImage: "photo")
                             }
                        } label: {
                            Label("add new plant", systemImage: "plus")
                                .foregroundColor(.accentColor)
                        }
                    })
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Model())
            .environmentObject(AddPlantViewModel())
    }
}
