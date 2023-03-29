//
//  LocationManager.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    static let shared = LocationManager()
    let manager = CLLocationManager()
    var complition: ((CLLocation)-> Void)?
    
    public func getUserLocation(complition: @escaping (CLLocation)-> Void) {
        self.complition = complition
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        complition?(location)
        manager.stopUpdatingLocation()
    }
}
