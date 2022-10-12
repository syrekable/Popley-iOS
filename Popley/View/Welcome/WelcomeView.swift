//
//  WelcomeView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 11/10/2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Color("Primary")
            VStack(spacing: 45) {
                VStack(spacing: 15) {
                    Text("Welcome to Popley")
                        .font(.title)
                        .fontWeight(.black)
                    Text("Your helping hand in keeping your plants healthy.")
                        .frame(width: 210)
                        .multilineTextAlignment(.center)
                }
                Image("sample-plant")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("Secondary"), lineWidth: 4))
                    Text("Swipe left to explore!")
            }
            .foregroundColor(.accentColor)
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
