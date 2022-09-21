//
//  Page.swift
//  Popley
//
//  Created by Jordan Niedzielski on 21/09/2022.
//

import Foundation

enum Page: Identifiable, CaseIterable {
    var id: Page { self }
    case plantName, plantSummary
}
