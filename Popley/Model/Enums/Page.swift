//
//  Page.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import Foundation
import UIKit

enum Page {
    var id: Page { self }
    case plantPicture, plantName(UIImage), plantSummary(String, UIImage)
}
