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
        NavigationView {
            ZStack {
                VStack(spacing: 15) {
                    Button {
                        model.source = .camera
                        model.isPickerShown = true
                    } label: {
                        ButtonLabel(description: "Take a photo", systemName: "camera")
                    }
                    Button {
                        model.source = .library
                        model.isPickerShown = true
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
        }
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
