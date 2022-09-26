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
    // TODO: test
    var isBackButtonHidden: Bool {
        return source == .camera && image == nil
    }
    
    var body: some View {
        ImagePicker(sourceType: source == .camera
                    ? .camera
                    : .photoLibrary,
                    selectedImage: $image)
            .onChange(of: image) { image in
                guard let image = image else { return }
                model.navigateToNextPage(.plantName(image))
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(isBackButtonHidden)
            .toolbar {
                if let image = image {
                    Button {
                        model.navigateToNextPage(.plantName(image))
                    } label: {
                        HStack {
                            Text("Next")
                            Image(systemName: "chevron.right")
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
    }
}

struct AddPlantPictureView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlantPictureView(source: .library)
            .environmentObject(Model())
    }
}
