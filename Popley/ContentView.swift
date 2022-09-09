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
                HStack(spacing: 0) {
                    Text("Ziemiokulkas")
                        .lineLimit(1)
                        .fontWeight(.bold)
                    .foregroundColor(Color("Tertiary"))
                    .padding([.horizontal])
                    .background {
                        Capsule()
                            .frame(minHeight: 50)
                            .opacity(0.75)
                            .foregroundColor(Color("Primary"))
                    }
                    .frame(maxWidth: 230, alignment: .leading)
                    Spacer()
                    Image(systemName: "gear")
                        .foregroundColor(Color("Accent"))
                }
                .font(.title)
                .padding([.top, .trailing])
            }
            HStack {
                VStack(alignment: .leading, spacing: 10) {
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
                VStack(alignment: .trailing, spacing: 10) {
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
