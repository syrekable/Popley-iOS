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
    let source: ImageSourcePicker.Source
    
    var body: some View {
        // TODO: 'next' button if image != nil
        // TODO: hide back navigation button when camera is used
        ImagePicker(sourceType: source == .camera
                    ? .camera
                    : .photoLibrary,
                    selectedImage: $image)
            .onChange(of: image) { image in
                guard let image = image else { return }
                model.navigateToNextPage(.plantName(image))
            }
            .ignoresSafeArea()
    }
}

struct AddPlantPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantPictureView(source: .library)
            .environmentObject(Model())
    }
}
