//
//  FileManager+Extension.swift
//  Popley
//
//  Created by Jordan Niedzielski on 04/10/2022.
//  Adopted from Stewart Lynch's 'My Image' photo app series

import Foundation
import UIKit

extension FileManager {
    static var docDirURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func readImage(with id: UUID) throws -> UIImage {
        let imageURL = FileManager.docDirURL.appendingPathComponent("\(id).jpeg")
        do {
            let imageData = try Data(contentsOf: imageURL)
            if let image = UIImage(data: imageData) {
                return image
            } else {
                throw MyImageError.readImageError
            }
        } catch {
            throw MyImageError.readImageError
        }
    }
}
