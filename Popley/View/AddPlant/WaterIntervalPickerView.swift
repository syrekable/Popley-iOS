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
                    Spacer()
                    Text("\(days) \(days == 1 ? "day" : "days")")
                        .foregroundColor(.accentColor)
                }
                Picker("Watering frequency in days", selection: $days) {
                    ForEach(1...90, id: \.self) { i in
                        Text("\(i) \(i == 1 ? "day" : "days")").tag(i)
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding()
        }
    }
}

struct WaterIntervalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WaterIntervalPickerView()
            .environmentObject(Model())
    }
}
