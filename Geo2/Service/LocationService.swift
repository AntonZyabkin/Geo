//
//  LocationService.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    func getUserLocation(complition: @escaping (CLLocation)-> Void)
}

final class LocationService: NSObject {
    let service = CLLocationManager()
    var complition: ((CLLocation)-> Void)?
}

extension LocationService: LocationServiceProtocol {
    
    func getUserLocation(complition: @escaping (CLLocation)-> Void) {
        self.complition = complition
        service.requestWhenInUseAuthorization()
        service.delegate = self
        service.startUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        complition?(location)
        manager.stopUpdatingLocation()
    }
}
