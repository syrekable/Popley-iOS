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
        ImagePicker(sourceType: addPlantViewModel.source == .camera
                    ? .camera
                    : .photoLibrary,
                    selectedImage: $addPlantViewModel.image)
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
                    .mask {
                        Circle()
                    }
                    .frame(height: diameter)
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
                        // TODO: check if empty
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
        VStack(spacing: 30) {
            HStack {
                if let image = addPlantViewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .mask {
                            Circle()
                        }
                        .frame(height: diameter / 2)
                } else {
                    Image("plant-zz")
                        .resizable()
                        .scaledToFit()
                        .frame(width: diameter / 2, height: diameter / 2)
                        .mask {
                            Circle()
                        }
                }
                Spacer()
                Text(addPlantViewModel.plantName)
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: 200, alignment: .center)
            }
            //.padding([.horizontal])
            Divider()
            Spacer()
            Button {
                // TODO: add debounce
                model.addPlant(addPlantViewModel.createPlant())
                model.navigateToRoot()
            } label: {
                ButtonLabel(description: "Add this plant", systemName: "hand.thumbsup.circle")
            }
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
                .environmentObject(AddPlantViewModel())
                .previewDisplayName("Plant Picture Screen")
            AddNewPlantPagePresenterView(page: .plantName)
                .environmentObject(Model())
                .environmentObject(AddPlantViewModel())
                .previewDisplayName("Plant Name Screen")
            AddNewPlantPagePresenterView(page: .plantSummary)
                .environmentObject(Model())
                .environmentObject(AddPlantViewModel())
                .previewDisplayName("Plant Summary Screen")
        }
    }
}
