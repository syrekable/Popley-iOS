//
//  RoundedCorner.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//  Adopted from https://stackoverflow.com/a/58606176/12938809

import Foundation
import SwiftUI

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
