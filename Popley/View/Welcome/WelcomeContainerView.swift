//
//  WelcomeContainerView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 11/10/2022.
//

import SwiftUI
import PageView

struct WelcomeContainerView: View {
    @State private var page: Int = 0
    var body: some View {
        HPageView(selectedPage: $page) {
            WelcomeView()
            FeatureListView()
            ExploreSettingsView()
        }
    }
}

struct WelcomeContainerView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeContainerView()
    }
}
