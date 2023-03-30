//
//  MainViewModel.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import MapKit
import Combine

protocol MainViewModelProtocol {
    var profileUser: User { get set }
    func didSelectRowAt(indexPath: IndexPath)
}

final class MainViewModel {
    
    var profileUser = User(name: "e-legion", imageName: "logo")
    var selectedUser: User
    var users: [User]
    
    private var timer = Timer()
    private var view: MainViewController
    private let dataService: MockServiceProtocol
    
    init(dataService: MockServiceProtocol, view: MainViewController) {
        self.dataService = dataService
        self.view = view
        self.selectedUser = profileUser
        users = dataService.fetchUsersFromAPI()
        start()
    }
    
    func start() {
        updateData()
        LocationService.shared.getUserLocation { [weak self] location in
            guard let self else { return }
            self.profileUser.location = location
            self.selectedUser = self.profileUser
            self.view.updateProfileData(user: self.profileUser)
            self.refreshUsers()
            self.calculate(distanceTo: self.selectedUser)
            self.view.reloadData()
        }
    }
    
    func updateData() {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.refreshUsers()
            self.calculate(distanceTo: self.selectedUser)
            self.view.reloadData()
            self.view.pinedUserView.configSubviews(user: self.selectedUser)
        }
    }
    
    func didSelectRowAt(indexPath: IndexPath) {

        if selectedUser.id == profileUser.id {
            selectedUser = users[indexPath.row]
            users.insert(selectedUser, at: 0)

        } else if selectedUser.id == users[indexPath.row].id {
            users.removeFirst()
            selectedUser = profileUser
        } else {
            users.removeFirst()
            selectedUser = users[indexPath.row - 1]
            users.insert(users[indexPath.row - 1], at: 0)
        }
        calculate(distanceTo: selectedUser)
        view.pinUser(user: selectedUser)
        self.view.reloadData()
    }
    
    func refreshUsers() {
        var refreshedUsers: [User] = []
        for i in self.users {
            var user = i
            if user.id != selectedUser.id {
                user.refreshCoordinates()
            }
            refreshedUsers.append(user)
            if selectedUser.id == user.id {
                selectedUser = user
            }
        }
        users = refreshedUsers
    }
    
    func calculate(distanceTo: User) {
        var refreshedUsers: [User] = []
        for i in self.users {
            var user = i
            user.distanse = user.location.distance(from: distanceTo.location)
            refreshedUsers.append(user)
        }
        users = refreshedUsers
    }
}

extension MainViewModel: MainViewModelProtocol {
    
}
