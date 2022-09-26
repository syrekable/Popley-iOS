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
                model.navigateToNextPage(.plantSummary(name, image, wateredEvery, lastWatered))
            } label: {
                HStack {
                    Text("Next")
                    Image(systemName: "chevron.right")
                }
            }

        }
    }
}

struct AddPlantWaterIntervalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddPlantWaterIntervalView(name: "Ziemiokulkas", image: UIImage(named: "plant-zz")!)
        }
    }
}
