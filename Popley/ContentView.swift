//
//  ContentView.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image("plant")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .mask {
                        Rectangle()
                    }
                HStack {
                    Text("Ziemiokulkas")
                        .fontWeight(.bold)
                        .foregroundColor(Color("Tertiary"))
                    Spacer()
                    Image(systemName: "gear")
                        .foregroundColor(Color("Accent"))
                }
                .font(.title)
                .padding()
            }
            HStack {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Time to water")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("1 day")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .frame(maxWidth: 125)
                        .foregroundColor(Color("Accent"))
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 15) {
                    Text("Water now")
                        .font(.title3)
                        .fontWeight(.bold)
                    Image(systemName: "drop.circle")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .frame(width: 100)
                        .foregroundColor(Color("Accent"))
                }
            }
            .padding([.horizontal, .bottom])
            .foregroundColor(Color("Tertiary"))
            .background {
                Color("Primary")
            }
        }
        .cornerRadius(10)
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
