//
//  AddPlantWaterIntervalView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct AddPlantWaterIntervalView: View {
    @EnvironmentObject var model: Model
    let name: String
    let image: UIImage
    @State private var wateredEvery: Int = 1
    @State private var lastWatered: Date = Date()
    
    
    var body: some View {
        VStack {
            HStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .mask {
                        Circle()
                    }
                    .frame(height: 125)
                Spacer()
                // TODO: limit lines or scale the size
                Text(name)
                    .font(.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: 200, alignment: .center)
            }
            .padding([.horizontal])
            Divider()
            WaterIntervalPickerView(wateredEvery: $wateredEvery, lastWatered: $lastWatered)
        }
        .navigationTitle("Set watering interval")
        .toolbar {
            Button {
                model.navigateToPage(.plantSummary(name, image, wateredEvery, lastWatered))
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

struct AddPlantWaterIntervalView_Previews: PreviewProvider {
    static let plant = Plant.sampleData.first!
    static var previews: some View {
        NavigationStack {
            AddPlantWaterIntervalView(name: plant.name, image: plant.imageWrapper.image)
        }
    }
}
