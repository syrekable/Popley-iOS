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
                        switch page {
                        case .plantPicture(let source):
                            AddPlantPictureView(source: source)
                        case .plantName(let image):
                            AddPlantNameView(image: image)
                        case .plantWaterInterval(let name, let image):
                            AddPlantWaterIntervalView(name: name, image: image)
                        case .plantSummary(let name, let image, let wateredEvery, let lastWatered):
                            AddPlantSummaryView(name: name, image: image, wateredEvery: wateredEvery, lastWatered: lastWatered)
                        case .appSettings:
                            AppSettingsView()
                        }
                    }
                    .navigationTitle("Your plants")
                    .toolbar(content: {
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button {
                                model.navigateToPage(.appSettings)
                            } label: {
                                Image(systemName: "gear")
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            imageSourcePickerContextMenu
                        }
                    })
                    .alert("Error", isPresented: $model.isCameraAlertShown, presenting: model.cameraError) { cameraError in
                        cameraError.button
                    } message: { cameraError in
                        Text(cameraError.message)
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

extension ContentView {
    var imageSourcePickerContextMenu: some View {
        Menu {
            Button {
                model.useDeviceCamera()
                if model.isCameraAvailable {
                    model.navigateToPage(.plantPicture(.camera))
                }
             } label: {
                 Label("Take a photo", systemImage: "camera")
             }
             Button {
                 model.navigateToPage(.plantPicture(.library))
             } label: {
                 Label("Pick existing", systemImage: "photo")
             }
        } label: {
            Label("add new plant", systemImage: "plus")
                .foregroundColor(.accentColor)
        }
    }
}
