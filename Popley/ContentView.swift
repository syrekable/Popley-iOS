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
                    Spacer()
                    Image(systemName: "gear")
                }
                .font(.title)
                .foregroundColor(.gray)
                .padding()
            }
            HStack {
                VStack(spacing: 20) {
                    Text("Time")
                        .font(.title2)
                    Text("1 day")
                        .font(.title3)
                }
                Spacer()
                VStack(spacing: 20) {
                    Text("Water")
                        .font(.title2)
                    Image(systemName: "drop.circle")
                        .font(.title3)
                }
            }
            .padding([.horizontal, .bottom])
            .background {
                Color.brown.opacity(0.3)
            }
            .cornerRadius(10, corners: [.bottomLeft, .bottomRight])
        }
        .padding()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
