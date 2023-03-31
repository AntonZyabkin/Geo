//
//  ViewController.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import UIKit

protocol MainViewControllerProtocol {
    func reloadData()
    func updateProfileData(user: User)
    func pinUser(user: User)
    func unpinUser()
    var pinedUserView: PinedUserView { get set }
    var usersTableView: UITableView { get set }
}

final class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol?
    
    private lazy var profileInfoView: ProfileInfoView = {
        let view = ProfileInfoView(frame: .zero, name: "e-legion", latitude: 0, longitude: 0, imageName: "logo")
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    lazy var usersTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.layer.cornerRadius = 15
        tableView.separatorStyle = .none
        return tableView
    }()
    
    lazy var pinedUserView: PinedUserView = {
        let view = PinedUserView(frame: .zero, user: User(name: "da", imageName: "logo"))
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.backgroundColor = .systemTeal
        view.alpha = 0
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configeTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configSubviews()
    }
    
    private func configSubviews() {
        view.addSubview(profileInfoView)
        view.addSubview(usersTableView)
        view.addSubview(pinedUserView)
        
        NSLayoutConstraint.activate([
            profileInfoView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            profileInfoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileInfoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileInfoView.heightAnchor.constraint(equalToConstant: 120),
            
            usersTableView.topAnchor.constraint(equalTo: profileInfoView.bottomAnchor, constant: 30),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            pinedUserView.topAnchor.constraint(equalTo: profileInfoView.bottomAnchor, constant: 30),
            pinedUserView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            pinedUserView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            pinedUserView.heightAnchor.constraint(equalToConstant: 92),
        ])
        
        profileInfoView.translatesAutoresizingMaskIntoConstraints = false
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
        pinedUserView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configeTableView() {
        usersTableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        usersTableView.rowHeight = 100
        usersTableView.dataSource = self
        usersTableView.delegate = self
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell,
            let user = presenter?.users[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.updateCell(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath)
    }
}


extension MainViewController: MainViewControllerProtocol {
    func reloadData() {
        usersTableView.reloadData()
    }
    
    func updateProfileData(user: User) {
        profileInfoView.changeCoordinates(
            latitude: user.location.coordinate.latitude,
            longitude: user.location.coordinate.longitude
        )
    }
    
    func pinUser(user: User) {
        pinedUserView.configSubviews(user: user)
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.pinedUserView.alpha = 1
        }
    }
    
    func unpinUser() {
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.pinedUserView.alpha = 0
        }
    }
}
