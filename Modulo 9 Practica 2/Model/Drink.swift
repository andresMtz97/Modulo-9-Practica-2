//
//  Drink.swift
//  Modulo 9 Practica 2
//
//  Created by Desarrollo on 16/07/24.
//

import Foundation
import SwiftUI

struct Drink: Codable {
    let directions: String
    let ingredients: String
    let name: String
    let img: String
    
    func getUIImage() -> UIImage? {
        let imageUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent(img, conformingTo: .image)
        let image = UIImage(contentsOfFile: imageUrl.path())
        return image
    }
}
