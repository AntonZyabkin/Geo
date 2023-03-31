//
//  MainViewModel.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import Foundation
import MapKit

protocol MainViewModelProtocol {
    func didSelectRowAt(indexPath: IndexPath)
    var users: [User] { get }
}

final class MainViewModel {
    
    private var profileUser = User(name: " ", imageName: "logo")
    private var selectedUser: User
    var users: [User]
    
    private var view: MainViewControllerProtocol
    private let dataService: MockServiceProtocol
    private let locationService: LocationServiceProtocol
    
    init(dataService: MockServiceProtocol, view: MainViewController, locationService: LocationServiceProtocol) {
        self.dataService = dataService
        self.locationService = locationService
        self.view = view
        self.selectedUser = profileUser
        users = dataService.fetchUsersFromAPI()
        let timer = Timer(timeInterval: 3, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        start()
    }
    
    private func start() {
        updateData()
        locationService.getUserLocation { [weak self] location in
            guard let self else { return }
            self.profileUser.location = location
            self.selectedUser = self.profileUser
            self.refreshUsers()
            self.calculate(distanceTo: self.selectedUser)
            DispatchQueue.main.async {
                self.view.updateProfileData(user: self.profileUser)
                self.view.reloadData()
            }
        }
    }
    
    @objc
    private func updateData() {
        refreshUsers()
        calculate(distanceTo: selectedUser)
        DispatchQueue.main.async {
            self.view.reloadData()
            self.view.pinedUserView.configSubviews(user: self.selectedUser)
        }
    }
    
    private func refreshUsers() {
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
    
    private func calculate(distanceTo: User) {
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
    
    func didSelectRowAt(indexPath: IndexPath) {
        switch selectedUser.id {
        case profileUser.id:
            selectedUser = users[indexPath.row]
            users.insert(selectedUser, at: 0)
            view.reloadData()
        case users[indexPath.row].id:
            users.removeFirst()
            view.reloadData()
            selectedUser = profileUser
        default:
            users.removeFirst()
            selectedUser = users[indexPath.row - 1]
            users.insert(users[indexPath.row - 1], at: 0)
        }
        
        calculate(distanceTo: selectedUser)
        
        if selectedUser.distanse != 0.0 {
            selectedUser.distanse = 0
            view.pinUser(user: selectedUser)
        } else {
            view.unpinUser()
        }
    }
}
