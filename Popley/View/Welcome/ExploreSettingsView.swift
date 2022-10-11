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
        VStack {
            Text("Now set the notification time that suits you best.")
            Button {
                model.didLaunchBefore = true
            } label: {
                ButtonLabel(description: "Open settings", systemName: "gear")
            }
        }
    }
}

struct ExploreSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreSettingsView()
    }
}
