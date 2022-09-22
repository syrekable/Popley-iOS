//
//  AddnewPlantPagePresenterView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 22/09/2022.
//

import SwiftUI

struct AddNewPlantPagePresenterView: View {
    @EnvironmentObject var model: Model
    @StateObject var addPlantViewModel = AddPlantViewModel()
    
    let page: Page
    var body: some View {
        switch page {
        case .plantPicture:
            plantPicture
        case .plantName:
            plantName
        case .plantSummary:
            plantSummary
        }
    }
}

extension AddNewPlantPagePresenterView {
    var plantPicture: some View {
        VStack(spacing: 15) {
            Button {
                /*
                 model.source = .camera
                 model.isPickerShown = true
                 */
                model.navigateToNextStageOfAddingNewPlant()
            } label: {
                ButtonLabel(description: "Take a photo", systemName: "camera")
            }
            Button {
                /*
                 model.source = .library
                 model.isPickerShown = true
                 */
                model.navigateToNextStageOfAddingNewPlant()
            } label: {
                ButtonLabel(description: "Pick existing", systemName: "photo")
            }
        }
            .navigationTitle("Add a new plant")
    }
    var plantName: some View {
        VStack {
            Text("See how deep the rabbit hole goes.")
                .font(.title)
            Button {
                model.navigateToNextStageOfAddingNewPlant()
            } label: {
                ButtonLabel(description: "Find out", systemName: "eye.fill")
            }
        }
            .navigationTitle("Change plant's name")
            .padding()
    }
    var plantSummary: some View {
        VStack {
            Text("This is the Matrix.")
            Button {
                model.navigateToRoot()
            } label: {
                ButtonLabel(description: "Shieeet", systemName: "brain.head.profile")
            }

        }
            .navigationTitle("New plant summary")
    }
}


struct AddNewPlantPagePresenterView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddNewPlantPagePresenterView(page: .plantPicture)
                .environmentObject(Model())
                .previewDisplayName("Plant Picture Screen")
            AddNewPlantPagePresenterView(page: .plantName)
                .environmentObject(Model())
                .previewDisplayName("Plant Name Screen")
            AddNewPlantPagePresenterView(page: .plantSummary)
                .environmentObject(Model())
                .previewDisplayName("Plant Summary Screen")
        }
    }
}
