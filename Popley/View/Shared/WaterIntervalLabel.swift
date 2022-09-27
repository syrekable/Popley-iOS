//
//  WaterIntervalLabel.swift
//  Popley
//
//  Created by Jordan Niedzielski on 26/09/2022.
//

import SwiftUI

struct WaterIntervalLabel: View {
    let description: String
    let iconName: String
    let intervalDescription: String
    var body: some View {
        HStack {
            Label(description, systemImage: iconName)
            Spacer()
            Text(intervalDescription)
                .fontWeight(.semibold)
        }
    }
}

struct WaterIntervalLabel_Previews: PreviewProvider {
    static var previews: some View {
        WaterIntervalLabel(description: "Next watering in:", iconName: "timer", intervalDescription: "13 days")
    }
}
