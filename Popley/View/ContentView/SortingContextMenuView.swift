//
//  SortingContextMenuView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 06/10/2022.
//

import SwiftUI

struct SortingContextMenuView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        Menu {
            Picker("Sorting", selection: $model.sorting) {
                ForEach(SortingOption.allCases) { option in
                    Text(String(describing: option))
                }
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down.square")
        }
    }
}

struct SortingContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SortingContextMenuView()
            .environmentObject(Model())
            .previewLayout(.sizeThatFits)
    }
}
