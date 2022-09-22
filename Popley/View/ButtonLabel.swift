//
//  ButtonLabel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 22/09/2022.
//

import SwiftUI

// TODO: rewrite as ButtonStyle
struct ButtonLabel: View {
    let description: String
    let systemName: String
    var body: some View {
        VStack(spacing: 10) {
            Text(description)
            Image(systemName: systemName)
        }
        .fontWeight(.bold)
        .padding()
        .foregroundColor(Color("Secondary"))
        .background {
            Color("Accent")
        }
        .cornerRadius(15)
    }
}

struct ButtonLabel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(description: "Take a picture", systemName: "photo")
    }
}
