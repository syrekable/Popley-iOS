//
//  AddPlantPictureView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct AddPlantPictureView: View {
    @EnvironmentObject var model: Model
    @State private var image: UIImage?
    let source: Picker.Source = .library
    
    var body: some View {
        ImagePicker(sourceType: source == .camera
                    ? .camera
                    : .photoLibrary,
                    selectedImage: $image)
            .onChange(of: image) { image in
                guard (image != nil) else { return }
                model.navigateToNextStageOfAddingNewPlant()
            }
    }
}

struct AddPlantPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantPictureView()
            .environmentObject(Model())
    }
}
