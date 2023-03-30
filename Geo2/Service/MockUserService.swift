//
//  MockUserService.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import CoreLocation

protocol MockServiceProtocol {
    func fetchUsersFromAPI() -> [User]
}

class MockService {
    var users: [User] = [
        User(name: "Dmitry Medvedev", imageName: "1"),
        User(name: "Anna Karenina", imageName: "2"),
        User(name: "Yuri Gagarin", imageName: "3"),
        User(name: "Georgy Pavlov", imageName: "4"),
        User(name: "Boris Demidovich", imageName: "5"),
        User(name: "Pitter Parker", imageName: "6"),
        User(name: "Frodo Bagins", imageName: "7"),
        User(name: "King Artur", imageName: "8"),
        User(name: "Captain Nemo", imageName: "9"),
        User(name: "Madara Uchiha", imageName: "10"),
        User(name: "Miyamoto Mussasy", imageName: "11"),
        User(name: "Adolf Hitler", imageName: "12"),
        User(name: "Infusoria Slipper", imageName: "13"),
        User(name: "Aladin", imageName: "14"),
    ]
}

extension MockService: MockServiceProtocol {
    
    func fetchUsersFromAPI() -> [User] {
        users
    }
}
