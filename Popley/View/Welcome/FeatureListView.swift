//
//  FeatureListView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 11/10/2022.
//

import SwiftUI

struct FeatureListView: View {
    var body: some View {
        ZStack {
            Color("Primary")
            VStack {
                VStack(spacing: 15) {
                    Text("Welcome to Popley")
                        .font(.title)
                        .fontWeight(.black)
                    Text("Three-steps startup guide.")
                        .frame(width: 210)
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(Color.accentColor)
                .padding(.bottom)
                Divider()
                ForEach(Feature.features) { feature in
                    FeatureOverView(systemName: feature.systemName, label: feature.label, caption: feature.caption)
                    Divider()
                }
            }
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

fileprivate struct Feature: Identifiable {
    var id: String { self.label }
    let systemName: String
    let label: String
    let caption: (String, String, String)
}

extension Feature {
    static let features = [
        Feature(systemName: "plus",
                label: "add",
                caption: (
                    "Add plant's picture and give it a name.",
                    "Set watering frequency and last watering date.",
                    "Add the new plant to your collection.")),
        Feature(systemName: "exclamationmark.bubble",
                label: "Be reminded",
                caption: ("Set preferred notification time.",
                          "Set back and do the things you enjoy.",
                          "When time comes, receive notification reminding you of your plants.")),
        Feature(systemName: "drop.circle",
                label: "Water",
                caption: ("Open the app when the watering time comes.",
                          "Check which plants to water.",
                          "Confirm and schedule next reminder with just a button click"))
    ]
}

struct FeatureListView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureListView()
    }
}

struct FeatureOverView: View {
    let systemName: String
    let label: String
    let caption: (String, String, String)
    var body: some View {
        HStack {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 55)
            Divider()
            VStack(alignment: .leading, spacing: 5) {
                Text(label.capitalized)
                    .font(.headline)
                Text(caption.0)
                Text(caption.1)
                Text(caption.2)
            }
            .frame(width: 260)
        }
        .frame(maxHeight: 165)
        .foregroundColor(.accentColor)
    }
}
