//
//  AddNewPlantView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import SwiftUI

struct AddPlantView: View {
    @StateObject var addPlantViewModel: AddPlantViewModel
    
    var body: some View {
        NavigationStack(path: $addPlantViewModel.navigationStack) {
            ZStack {
                List(Page.allCases) { page in
                    NavigationLink(value: page, label: {
                        AddNewPlantPagePresenterView(page: page)
                    })
                }
                    .navigationDestination(for: Page.self) { page in
                        AddNewPlantPagePresenterView(page: page)
                    }
                    .opacity(0)
                VStack(spacing: 15) {
                    Button {
                        /*
                         model.source = .camera
                         model.isPickerShown = true
                         */
                    } label: {
                        ButtonLabel(description: "Take a photo", systemName: "camera")
                    }
                    Button {
                        /*
                         model.source = .library
                         model.isPickerShown = true
                         */
                        addPlantViewModel.navigateToNextPage()
                    } label: {
                        ButtonLabel(description: "Pick existing", systemName: "photo")
                    }
                }
                    .navigationTitle("Add a new plant")
                if addPlantViewModel.isPickerShown {
                    ImagePicker(sourceType: addPlantViewModel.source == .camera ?  .camera : .photoLibrary,
                                selectedImage: $addPlantViewModel.image)
                    //.ignoresSafeArea()
                }
            }
            /*
             .onChange(of: model.image) { newValue in
                 model.navigateToPlant()
             }
             */
        }
            .environmentObject(addPlantViewModel)
    }
}

struct AddNewPlantView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantView(addPlantViewModel: AddPlantViewModel())
    }
}

struct AddNewPlantPagePresenterView: View {
    @EnvironmentObject var addPlantVM: AddPlantViewModel
    @State private var text: String = "rabbit hole"
    let page: Page
    var body: some View {
        if page == .plantName {
            VStack {
                Text("See how deep the \(text) goes.")
                    .font(.title)
                TextField("Fill your destiny", text: $text)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        addPlantVM.navigateToNextPage()
                    }
            }
                .navigationTitle("Change plant's name")
                .padding()
        } else {
            Text("This is the Matrix.")
                .navigationTitle("New plant summary")
        }
    }
}
