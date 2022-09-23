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
    let source: Picker.Source
    
    var body: some View {
        // TODO: 'next' button if image != nil
        ImagePicker(sourceType: source == .camera
                    ? .camera
                    : .photoLibrary,
                    selectedImage: $image)
            .onChange(of: image) { image in
                guard let image = image else { return }
                model.navigateToNextPage(.plantName(image))
            }
    }
}

struct AddPlantPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantPictureView(source: .library)
            .environmentObject(Model())
    }
}
