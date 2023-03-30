//
//  LocationService.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import CoreLocation


final class LocationService: NSObject {
    static let shared = LocationService()
    let service = CLLocationManager()
    var complition: ((CLLocation)-> Void)?
    
    public func getUserLocation(complition: @escaping (CLLocation)-> Void) {
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
