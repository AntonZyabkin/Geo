//
//  MainModel.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import CoreLocation

struct User: Equatable {
    var name: String
    var imageName: String
    var location: CLLocation
    var distanse: Double
    let id = UUID()
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
        self.location = CLLocation(latitude: 0, longitude: 0)
        self.distanse = 0
    }
    init() {
        self.name = ""
        self.imageName = "logo"
        self.location = CLLocation(latitude: 0, longitude: 0)
        self.distanse = 0
    }
    
    mutating func refreshCoordinates() {
        location = CLLocation(
            latitude: Double.random(in: (-90.0...90.0)),
            longitude: Double.random(in: (-180.0...180.0))
        )
    }
}
