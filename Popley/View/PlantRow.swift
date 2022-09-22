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
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image(plant.picture)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                HStack(spacing: 0) {
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
                    Spacer()
                    Button {
                        navigateToPlantDetailsAction(plant)
                    } label: {
                        Image(systemName: "info.circle")
                    }
                    .foregroundColor(Color("Accent"))         
                }
                .font(.title)
                .padding([.top, .trailing])
            }
            HStack {
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
                    .foregroundColor(Color("Accent"))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 10) {
                    Text("Water now")
                        .font(.title3)
                        .fontWeight(.bold)
                    Image(systemName: "drop.circle")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .frame(width: 100)
                        .foregroundColor(Color("Accent"))
                }
            }
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

/*
 struct PlantCardView_Previews: PreviewProvider {
 private static let zzPlant = Plant.sampleData[1]
 static var previews: some View {
 PlantRow(name: zzPlant.name,
 timeToWater: zzPlant.waterInterval,
 imageName: zzPlant.picture,
 waterAction: { print("💦") }),
 navigateToPlantDetailsAction: { _ in return Void})
 }
 }
 */