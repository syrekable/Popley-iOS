//
//  AddnewPlantPagePresenterView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 22/09/2022.
//

import SwiftUI

struct AddNewPlantPagePresenterView: View {
    @EnvironmentObject var model: Model
    @EnvironmentObject var addPlantViewModel: AddPlantViewModel
    let page: Page
    
    var body: some View {
        switch page {
        case .plantPicture:
            plantPicture
        case .plantName:
            plantName
        case .plantSummary:
            plantSummary
        }
    }
}

extension AddNewPlantPagePresenterView {
    private var diameter: CGFloat { 250 }
    var plantPicture: some View {
        VStack(spacing: 15) {
            Button {
                /*
                 model.source = .camera
                 model.isPickerShown = true
                 */
                // model.navigateToNextStageOfAddingNewPlant()
                print("Not coded yet")
            } label: {
                ButtonLabel(description: "Take a photo", systemName: "camera")
            }
                .disabled(true)
                .opacity(0.6)
            Button {
                addPlantViewModel.source = .library
                addPlantViewModel.showPhotoPicker()
            } label: {
                ButtonLabel(description: "Pick existing", systemName: "photo")
            }
        }
            .navigationTitle("Add a new plant")
            .sheet(isPresented: $addPlantViewModel.isPickerShown) {
                 ImagePicker(sourceType: addPlantViewModel.source == .camera
                             ? .camera
                             : .photoLibrary,
                             selectedImage: $addPlantViewModel.image)
            }
            .onChange(of: addPlantViewModel.image) { image in
                guard (image != nil) else { return }
                //print(image)
                model.navigateToNextStageOfAddingNewPlant()
            }
    }
    var plantName: some View {
        return VStack {
            if let image = addPlantViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: diameter)
                    .mask {
                        Circle()
                    }
            } else {
                Image("plant-zz")
                    .resizable()
                    .scaledToFit()
                    .frame(height: diameter)
                    .mask {
                        Circle()
                    }
            }
            HStack {
                TextField("New plant's name", text: $addPlantViewModel.plantName)
                    .onSubmit {
                        model.navigateToNextStageOfAddingNewPlant()
                    }
                Button {
                    model.navigateToNextStageOfAddingNewPlant()
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                }
            }
            Spacer()
        }
            .navigationTitle("Change plant's name")
            .padding()
    }
    var plantSummary: some View {
        VStack {
            HStack {
                if let image = addPlantViewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: diameter / 2)
                        .mask {
                            Circle()
                        }
                } else {
                    Image("plant-zz")
                        .resizable()
                        .scaledToFit()
                        .frame(height: diameter / 2)
                        .mask {
                            Circle()
                        }
                }
                Spacer()
                Text(addPlantViewModel.plantName)
                    .font(.title)
                    .fontWeight(.medium)
            }
            //.padding([.horizontal])
            Divider()
            Spacer()
        }
            .navigationTitle("New plant summary")
            .padding([.horizontal])
    }
}


struct AddNewPlantPagePresenterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddNewPlantPagePresenterView(page: .plantPicture)
                .environmentObject(Model())
                .previewDisplayName("Plant Picture Screen")
            AddNewPlantPagePresenterView(page: .plantName)
                .environmentObject(Model())
                .previewDisplayName("Plant Name Screen")
            AddNewPlantPagePresenterView(page: .plantSummary)
                .environmentObject(Model())
                .previewDisplayName("Plant Summary Screen")
        }
    }
}
