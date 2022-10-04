//
//  MyImage.swift
//  Popley
//
//  Created by Jordan Niedzielski on 04/10/2022.
//

import UIKit

struct MyImage: Identifiable, Codable {
    var id = UUID()
    
    var image: UIImage {
        do {
            return try FileManager().readImage(with: id)
        } catch {
            return UIImage(systemName: "photo.fill")!
        }
    }
}
