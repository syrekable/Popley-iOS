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
            VStack {
                VStack(spacing: 15) {
                    Text("Welcome to Popley")
                        .font(.title)
                        .fontWeight(.black)
                    Text("Now set the notification time that suits you best.")
                        .frame(width: 210)
                        .multilineTextAlignment(.center)
                }
                .foregroundColor(Color("Primary"))
                Spacer()
                Button {
                    model.didLaunchBefore = true
                } label: {
                    ButtonLabel(description: "Open settings", systemName: "gear")
                }
            }
            // FIXME: arbitrary size
            .frame(height: 700)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ExploreSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSettingsView()
    }
}
