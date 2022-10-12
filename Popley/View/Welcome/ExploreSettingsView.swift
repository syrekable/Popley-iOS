//
//  ExploreSettingsView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 11/10/2022.
//

import SwiftUI

struct ExploreSettingsView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack {
            Color("Secondary")
            VStack(spacing: 45) {
                VStack(spacing: 15) {
                    Text("Welcome to Popley")
                        .font(.title)
                        .fontWeight(.black)
                    Text("Now set the notification time that suits you best.")
                        .frame(width: 210)
                        .multilineTextAlignment(.center)
                }
                Image("icon-plant")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("Tertiary"), lineWidth: 4))
                Button {
                    model.didLaunchBefore = true
                } label: {
                    ButtonLabel(description: "Open settings", systemName: "gear")
                }
            }
            .foregroundColor(Color("Primary"))
            .padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ExploreSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSettingsView()
    }
}
