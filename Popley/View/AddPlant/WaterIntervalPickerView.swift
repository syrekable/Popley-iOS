//
//  WaterIntervalPickerView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct WaterIntervalPickerView: View {
    @EnvironmentObject var model: Model
    @State private var days: Int = 1
    @State private var lastWatered: Date = Date()
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Every")
                    Text("\(days) \(days == 1 ? "day" : "days")")
                }
            }
        }
    }
}

struct WaterIntervalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WaterIntervalPickerView()
            .environmentObject(Model())
    }
}
