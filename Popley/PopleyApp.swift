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
    @StateObject private var addNewPlantModel = AddPlantViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
                .environmentObject(addNewPlantModel)
        }
    }
}
