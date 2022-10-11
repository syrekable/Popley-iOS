//
//  OrderSubMenuView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 06/10/2022.
//

import SwiftUI

struct OrderSubMenuView: View {
    let pickAscending: () -> Void
    let pickDescending: () -> Void
    var body: some View {
        Menu {
            Button {
                pickAscending()
            } label: {
                HStack {
                    Text("ascending")
                    Image(systemName: "arrow.up")
                }
            }
            Button {
                pickDescending()
            } label: {
                HStack {
                    Text("descending")
                    Image(systemName: "arrow.down")
                }
            }
        } label: {
            
        }
    }
}

struct OrderSubMenuView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSubMenuView(pickAscending: {}, pickDescending: {})
    }
}
