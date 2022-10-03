//
//  KeyValueStorable.swift
//  Popley
//
//  Created by Jordan Niedzielski on 29/09/2022.
//

import Foundation

protocol KeyValueStorable {
    func double(forKey: String) -> Double
    func set(_: Double, forKey: String)
}
