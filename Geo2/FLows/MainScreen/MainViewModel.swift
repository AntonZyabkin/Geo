//
//  MainViewModel.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import MapKit

protocol MainViewModelProtocol {
    var myLocation: CLLocation { get set }
}

final class MainViewModel {
    var myLocation = CLLocation()
    
    init(myLocation: CLLocation = CLLocation()) {
        self.myLocation = myLocation
        LocationManager.shared.getUserLocation { location in
            self.myLocation = location
        }
    }
}

extension MainViewModel: MainViewModelProtocol {
    
}
