//
//  StyleGuide.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct StyleGuide: View {
    let colorNames = ["primary", "secondary", "tertiary", "accent"]
            .map { $0.capitalized }
    var body: some View {
        ScrollView {
            VStack {
                AppColorsView(colorNames: colorNames)
                ColorReadabilityView(colorNames: colorNames)
            }
            .padding(.horizontal)
        }
    }
}

extension Font.Weight: CaseIterable {
    public static var allCases: [Font.Weight] {
        [.ultraLight, .thin, .light, .regular, .medium, .semibold, .bold, .heavy, .black]
    }
}

struct ColorReadabilityView: View {
    let colorNames: [String]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Colors on each other")
                .font(.title)
            ForEach(Array(zip(colorNames, colorNames.reversed())), id: \.0) { (color, oposite) in
                ZStack {
                    Color(color)
                        .cornerRadius(10)
                    VStack {
                        ForEach(Font.Weight.allCases.reversed(), id: \.self) { weight in
                            Text("\(oposite) on \(color)")
                                .foregroundColor(Color(oposite))
                                .fontWeight(weight)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct AppColorsView: View {
    let colorNames: [String]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("App colors")
                .font(.title)
            ForEach(colorNames, id: \.self) { name in
                HStack(spacing: 25) {
                    Color(name)
                        .frame(width: 100, height: 50)
                        .cornerRadius(10)
                    Text("This is sample text")
                        .foregroundColor(Color(name))
                    //Spacer()
                    Text(name)
                        .frame(maxWidth: 120, alignment: .leading)
                }
            }
        }
    }
}

struct StyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        StyleGuide()
    }
}
