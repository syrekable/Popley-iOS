//
//  PopleyApp.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

@main
struct PopleyApp: App {
    @StateObject private var model = Model()
    var body: some Scene {
        WindowGroup {
            if !model.didLaunchBefore {
                WelcomeContainerView()
                    .environmentObject(model)
            } else {
                ContentView()
                    .environmentObject(model)
            }
        }
    }
}
