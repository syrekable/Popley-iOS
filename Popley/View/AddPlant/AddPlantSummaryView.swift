//
//  AddPlantSummaryView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct AddPlantSummaryView: View {
    @Environment(\.scenePhase) var scene
    @EnvironmentObject var model: Model
    @State private var plant: Plant?
    let name: String
    let image: UIImage
    let wateredEvery: Int
    let lastWatered: Date
    
    var body: some View {
        ZStack {
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
                    WaterIntervalLabel(description: "Needs water every:", iconName: "calendar.circle", intervalDescription: String(describing: plant.waterInterval))
                    WaterIntervalLabel(description: "Next watering in:", iconName: "timer", intervalDescription: String(describing: plant
                        .timeToWater
                        .asDescriptiveDateInterval
                    ))
                    Spacer()
                    addPlantButton
                } else {
                    ProgressView()
                }
            }
            .if(!model.isNotificationAuthorized) { view in
                view.overlay(.ultraThinMaterial.opacity(0.7))
            }
            if !model.isNotificationAuthorized {
                Color("Secondary").opacity(0.4)
                    .cornerRadius(15)
                requestAuthorizationMessage
                    .padding()
            }
        }
        .navigationTitle("New plant summary")
        .padding()
        .onAppear {
            plant = model.createPlant(named: name, withPicture: image, wateredEvery: wateredEvery, lastWatered: lastWatered)
            model.requestAuthorization()
        }
        .onChange(of: scene, perform: { _ in
            model.refreshAuthorizationStatus()
        })
    }
}

extension AddPlantSummaryView {
    var requestAuthorizationMessage: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Let \(plant?.name ?? "this plant") flourish")
                .font(.title)
                .bold()
            Text("Let Popley notify you when to water \(plant?.name ?? "this") and other plants. Please, enable notification permission for Popley in the Settings app.")
                .fontWeight(.semibold)
        }.foregroundColor(.accentColor)
    }
    var addPlantButton: some View {
        Button {
            model.addPlant(plant!)
            model.navigateToRoot()
        } label: {
            ButtonLabel(description: "Add this plant", systemName: "hand.thumbsup.circle")
        }
        .disabled(!model.isNotificationAuthorized)
        .opacity(model.isNotificationAuthorized ? 1 : 0.6)
    }
}

struct AddPlantSummaryView_Previews: PreviewProvider {
    static let plant = Plant.sampleData.last!
    static var previews: some View {
        NavigationStack {
            AddPlantSummaryView(name: plant.name, image: plant.picture, wateredEvery: plant.waterInterval.frequency, lastWatered: Date())
                .environmentObject(Model())
        }
            .previewDisplayName("Notifications disabled")
        NavigationStack {
            AddPlantSummaryView(name: plant.name, image: plant.picture, wateredEvery: plant.waterInterval.frequency, lastWatered: Date())
                .environmentObject(Model.withNotificationsEnabled())
                
        }
            .previewDisplayName("Notifications enabled")
    }
}
