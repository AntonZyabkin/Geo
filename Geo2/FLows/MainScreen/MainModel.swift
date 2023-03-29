//
//  MainModel.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
struct User: Codable {
    var name: String
    var imageName: String
    var latitude: Double
    var longitude: Double
    var distanse: Double = 0
}
