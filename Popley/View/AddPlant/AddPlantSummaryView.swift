//
//  AddPlantSummaryView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct AddPlantSummaryView: View {
    @EnvironmentObject var model: Model
    let name: String
    let image: UIImage
    
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .mask {
                        Circle()
                    }
                    .frame(height: 125)
                Spacer()
                Text(name)
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: 200, alignment: .center)
            }
            //.padding([.horizontal])
            Divider()
            Spacer()
            Button {
                // TODO: add debounce
                model.addPlant(named: name, withPicture: image, wateredEvery: WaterInterval(), lastWatered: Date())
                model.navigateToRoot()
            } label: {
                ButtonLabel(description: "Add this plant", systemName: "hand.thumbsup.circle")
            }
        }
            .navigationTitle("New plant summary")
            .padding()// [.horizontal, .bottom]?
    }
}

struct AddPlantSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddPlantSummaryView(name: "Aloes", image: UIImage(named: "plant-aloe")!)
                .environmentObject(Model())
        }
    }
}