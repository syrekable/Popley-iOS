//
//  WaterIntervalPickerView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 23/09/2022.
//

import SwiftUI

struct WaterIntervalPickerView: View {
    @EnvironmentObject var model: Model
    @Binding var days: Int
    @Binding var lastWatered: Date
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                HStack {
                    Text("Every")
                    Spacer()
                    Text("\(days) \(days == 1 ? "day" : "days")")
                        .foregroundColor(.accentColor)
                }
                Divider()
                Picker("Watering frequency in days", selection: $days) {
                    ForEach(1...90, id: \.self) { i in
                        Text("\(i) \(i == 1 ? "day" : "days")").tag(i)
                    }
                }
                .pickerStyle(.wheel)
            }
            .padding()
            .background(Color("Primary"))
            .cornerRadius(10)
            DatePicker("Last watered", selection: $lastWatered, displayedComponents: [.date])
            // TODO: their vertical padding is half the horizontal
                .padding()
                .background(Color("Primary"))
                .cornerRadius(10)
        }
        .padding()
    }
}

struct WaterIntervalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WaterIntervalPickerView(days: .constant(1), lastWatered: .constant(Date()))
            .environmentObject(Model())
            .previewLayout(.sizeThatFits)
    }
}
