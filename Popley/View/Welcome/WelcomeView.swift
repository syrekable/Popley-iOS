//
//  WelcomeView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 11/10/2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to Popley")
            Text("Your helping hand in keeping your plants healthy.")
            Text("Swipe left to explore!")
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
