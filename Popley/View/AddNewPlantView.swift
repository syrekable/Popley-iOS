//
//  AddNewPlantView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import SwiftUI

struct AddNewPlantView: View {
    @StateObject var model: AddNewPlantViewModel
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Button {
                    
                } label: {
                    VStack(spacing: 10) {
                        Text("Take a photo")
                        Image(systemName: "camera")
                    }
                }
                .padding()
                .background {
                    Color("Accent")
                }
                .cornerRadius(15)
                Button {
                    
                } label: {
                    VStack(spacing: 10) {
                        Text("Pick existing")
                        Image(systemName: "photo")
                    }
                }
                .padding()
                .background {
                    Color("Accent")
                }
                .cornerRadius(15)
            }
            .fontWeight(.heavy)
            .foregroundColor(Color("Secondary"))
            .navigationTitle("Add a new plant")
        }
    }
}

struct AddNewPlantView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPlantView(model: AddNewPlantViewModel())
    }
}
