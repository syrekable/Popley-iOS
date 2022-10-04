//
//  UIImageWrapper.swift
//  Popley
//
//  Created by Jordan Niedzielski on 04/10/2022.
//

import UIKit

struct UIImageWrapper: Identifiable, Hashable, Codable {
    let id: UUID
    
    var image: UIImage {
        do {
            return try FileManager().readImage(with: id)
        } catch {
            // TODO: something pretty
            return UIImage(systemName: "photo.circle")!
        }
    }
}
