//
//  MockUserService.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation

protocol MockServiceProtocol {
    func ferchUsersFromAPI() -> [User]
}

class MockService {
    
    private let users: [User] = [
        User(name: "Dmitry", imageName: "bell", latitude: 30, longitude: -20),
        User(name: "Ana", imageName: "heart", latitude: 17.519, longitude: 0),
        User(name: "Ura", imageName: "plus", latitude: 7.519, longitude: 120),
        User(name: "Geo", imageName: "person", latitude: 14.519, longitude: 31),
        User(name: "Pet", imageName: "dog", latitude: 32.519, longitude: 27),
    ]
}

extension MockService: MockServiceProtocol {
    func ferchUsersFromAPI() -> [User] {
        users
    }
}
