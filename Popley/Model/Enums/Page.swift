//
//  Page.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import Foundation
import UIKit

enum Page: Hashable {
    case plantPicture(Picker.Source), plantName(UIImage), plantSummary(String, UIImage)
}
