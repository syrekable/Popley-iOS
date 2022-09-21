//
//  AddNewPlantView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import SwiftUI

struct AddNewPlantView: View {
    @StateObject var model: AddNewPlantViewModel
    
    var body: some View {
        NavigationStack(path: $model.navigationStack) {
            ZStack {
                NavigationLink(value: Page.plantName, label: {
                    Text("h4ck3rm4n")
                })
                    .opacity(0)
                VStack(spacing: 15) {
                    Button {
                        model.source = .camera
                        model.isPickerShown = true
                    } label: {
                        ButtonLabel(description: "Take a photo", systemName: "camera")
                    }
                    Button {
                        /*
                         model.source = .library
                         model.isPickerShown = true
                         */
                        model.navigateFurther()
                    } label: {
                        ButtonLabel(description: "Pick existing", systemName: "photo")
                    }
                }
                .navigationTitle("Add a new plant")
                if model.isPickerShown {
                    ImagePicker(sourceType: model.source == .camera ?  .camera : .photoLibrary,
                                selectedImage: $model.image)
                    //.ignoresSafeArea()
                }
            }
                .navigationDestination(for: Page.self) { page in
                    AddNewPlantNameView(page: page)
                }
                .onChange(of: model.image) { newValue in
                    model.navigateFurther()
                }
        }
            .environmentObject(model)
            
    }
}

struct AddNewPlantView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlantView(model: AddNewPlantViewModel())
    }
}

// TODO: rewrite as ButtonStyle
struct ButtonLabel: View {
    let description: String
    let systemName: String
    var body: some View {
        VStack(spacing: 10) {
            Text(description)
            Image(systemName: systemName)
        }
        .fontWeight(.bold)
        .padding()
        .foregroundColor(Color("Secondary"))
        .background {
            Color("Accent")
        }
        .cornerRadius(15)
    }
}

struct AddNewPlantNameView: View {
    @EnvironmentObject var addPlantVM: AddNewPlantViewModel
    @State private var text: String = "rabbit hole"
    let page: Page
    var body: some View {
        VStack {
            ZStack {
                NavigationLink(value: Page.plantSummary, label: {
                    Text("h4ck3rm4n")
                })
                    .opacity(0)
                Text("See how deep the \(text) goes.")
                    .navigationTitle("Change plant's name")
            }
                .navigationDestination(for: Page.self) { page in
                    AddNewPlantNameView(page: page)
                }
            TextField("Fill your destiny", text: $text)
                .textFieldStyle(.plain)
                .onSubmit {
                    addPlantVM.navigateFurther()
                }
        }
        .padding()
    }
}

struct AddNewPlantSummaryView: View {
    let page: Page
    var body: some View {
        Text("This is the Matrix.")
            .navigationTitle("Summary of your new plant.")
    }
}
