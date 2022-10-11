//
//  ContentView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: Model
    @State private var updater: Int = 0
    var body: some View {
        NavigationStack(path: $model.path) {
            ScrollView {
                VStack {
                    if(model.plants.isEmpty) {
                        addPlantEngouragement
                    }
                    ForEach(model.sortedPlants) { plant in
                        PlantRow(plant: plant,
                                 navigateToPlantDetailsAction: model.navigateToPlant)
                    }
                    .task {
                        if FileManager().documentExist(named: fileName) {
                            model.loadMyImagesJSONFile()
                        }
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
                            SortingContextMenuView()
                            /*
                             although the selection value *should* update by itself,
                             since model.sorting is @Published, which manifests in
                             the view actually sorting the elements,
                             the Picker in the Menu won't update its bound value
                             unless I preform this disgrace
                             */
                            // FIXME: sync the selected value without this abomination
                                .onChange(of: model.sorting) { _ in
                                    updater += 1
                                }
                                .id(updater)
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
            .sheet(isPresented: $model.isShowingThirstyPlants) {
                ThirstyPlantList()
                    .interactiveDismissDisabled()
            }
            .onAppear {
                model.checkForThirstyPlants()
            }
            .onChange(of: model.plants) { _ in
                model.checkForThirstyPlants()
            }
            .onChange(of: model.sorting) { newValue in
                print("Sorting \(newValue) now")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
                .environmentObject(Model.withWateredPlants())
        }
            .previewDisplayName("With watered plants")
        NavigationStack {
            ContentView()
                .environmentObject(Model.withThirstyPlants())
        }
            .previewDisplayName("With thirsty plants")
    }
}

// MARK: grouped subviews
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
    var addPlantEngouragement: some View {
        Text("Hello, world!")
    }
}
