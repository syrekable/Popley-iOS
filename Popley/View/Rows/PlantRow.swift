//
//  PlantCardView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct PlantRow: View {
    let plant: Plant
    let navigateToPlantDetailsAction: (Plant) -> Void
    
    // FIXME: get rid of all arbitrarily scaled views
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image(uiImage: plant.imageWrapper.image)
                    .resizable()
                    .scaledToFill()
                // fixed
                    .frame(width: 360, height: 300)
                HStack(spacing: 0) {
                    plantName
                    Spacer()
                    infoButton
                }
                .font(.title)
                .padding([.top, .trailing])
            }
            HStack {
                timeToWater
                Spacer()
                progressBar
            }
            .frame(maxHeight: 60)
            .padding([.horizontal, .bottom])
            .foregroundColor(Color("Tertiary"))
            .background {
                Color("Primary")
            }
            .lineLimit(1)
        }
        .cornerRadius(10)
        .padding()
        .shadow(radius: 6, y: 3)
    }
}


struct PlantCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlantRow(plant: Plant.sampleData.first!) { _ in }
    }
}

extension PlantRow {
    var plantName: some View {
        Text(plant.name)
            .lineLimit(1)
            .fontWeight(.bold)
            .foregroundColor(Color("Tertiary"))
            .padding([.horizontal])
            .background {
                Color("Primary")
                    .frame(minHeight: 50)
                    .opacity(0.75)
                    .cornerRadius(10, corners: [.topRight, .bottomRight])
            }
            .frame(maxWidth: 230, alignment: .leading)
    }
    var infoButton: some View {
        Button {
            navigateToPlantDetailsAction(plant)
        } label: {
            Image(systemName: "info.circle")
        }
        .foregroundColor(Color.accentColor)
        .shadow(color: Color("Primary").opacity(0.9), radius: 3, x: 2, y: 2)
    }
    var timeToWater: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Time to water")
                .font(.title3)
                .fontWeight(.bold)
            Text(
                String(describing: plant
                    .timeToWater
                    .asDescriptiveDateInterval
                ))
            .font(.title2)
            .fontWeight(.heavy)
            .frame(maxWidth: 125)
            .foregroundColor(Color.accentColor)
        }
    }
    var progressBar: some View {
        VStack(spacing: 10) {
            Text("Dry-o-meter")
                .font(.title3)
                .fontWeight(.bold)
            // TODO: get this logic outta here
            //Spacer()
            ProgressView(value: Date.now.timeIntervalSince(plant.lastWaterDate),
                         total: plant.timeToWater.end
                .timeIntervalSince(plant.lastWaterDate))
            // fixed
            .frame(width: 100, height: 26)
        }
    }
}
