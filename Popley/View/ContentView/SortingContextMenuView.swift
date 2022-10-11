//
//  SortingContextMenuView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 06/10/2022.
//

import SwiftUI

struct SortingContextMenuView: View {
    @EnvironmentObject var model: Model
    @State private var order: SortingOption = .byName(.ascending)
    var body: some View {
        Menu {
            ForEach(SortingOption.allCases.reversed()) { option in
                Button {
                    order = option
                } label: {
                    Text(String(describing: option.description))
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
