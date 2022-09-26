//
//  AddPlantSummaryView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct AddPlantSummaryView: View {
    @EnvironmentObject var model: Model
    @State private var plant: Plant?
    let name: String
    let image: UIImage
    let wateredEvery: Int
    let lastWatered: Date
    
    var body: some View {
        VStack(spacing: 30) {
            if let plant = plant {
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
                Divider()
                // TODO: 38 days -> "~ 1 month" or "> 1 month" instead of "1 month"?
                WaterInvervalLabel(description: "Needs water every:", iconName: "calendar.circle", intervalDescription: String(describing: plant.waterInterval))
                WaterInvervalLabel(description: "Next watering in:", iconName: "timer", intervalDescription: String(describing: plant
                    .timeToWater
                    .asDescriptiveDateInterval
                ))
                Spacer()
                Button {
                    // TODO: add debounce
                    model.addPlant(plant)
                    model.navigateToRoot()
                } label: {
                    ButtonLabel(description: "Add this plant", systemName: "hand.thumbsup.circle")
                }
            } else {
                ProgressView()
            }
        }
            .navigationTitle("New plant summary")
            .padding()// [.horizontal, .bottom]?
            .onAppear {
                plant = model.createPlant(named: name, withPicture: image, wateredEvery: wateredEvery, lastWatered: lastWatered)
            }
    }
}

struct AddPlantSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddPlantSummaryView(name: "Aloes", image: UIImage(named: "plant-aloe")!, wateredEvery: 1, lastWatered: Date())
                .environmentObject(Model())
        }
    }
}
