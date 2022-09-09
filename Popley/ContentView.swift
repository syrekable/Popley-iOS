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
                VStack(spacing: 20) {
                    Text("Time")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("1 day")
                        .font(.title3)
                }
                Spacer()
                VStack(spacing: 20) {
                    Text("Water")
                        .font(.title2)
                        .fontWeight(.bold)
                    Image(systemName: "drop.circle")
                        .font(.title3)
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
