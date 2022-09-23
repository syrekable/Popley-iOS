//
//  AddPlantNameView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct AddPlantNameView: View {
    @EnvironmentObject var model: Model
    @State private var plantName = ""
    let image: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .mask {
                    Circle()
                }
                .frame(height: 250)
            HStack {
                TextField("New plant's name", text: $plantName)
                    .onSubmit {
                        // TODO: check if empty
                        model.navigateToNextPage(.plantWaterInterval(plantName, image))
                    }
                Button {
                    model.navigateToNextPage(.plantWaterInterval(plantName, image))
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                }
            }
            Spacer()
        }
            .navigationTitle("Name the plant")
            .padding()

    }
}

struct AddPlantNameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddPlantNameView(image: UIImage(named: "plant-zz")!)
                .environmentObject(Model())
        }
    }
}
