//
//  CornerRadius.swift
//  Popley
//
//  Created by Jordan Niedzielski on 09/09/2022.
//  Adopted from https://stackoverflow.com/a/58606176/12938809

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
