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
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct StyleGuide_Previews: PreviewProvider {
    static var previews: some View {
        StyleGuide()
    }
}
