//
//  ViewController.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import UIKit

class MainViewController: UIViewController {
    var viewModel: MainViewModelProtocol?
    
    private lazy var profileBackgroundView: UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Name: e-legion"
        return label
    }()
    private lazy var latitudeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "latitude: 123125124 "
        return label
    }()
    private lazy var longitudeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "longitude: 124124124 "
        return label
    }()
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        let image = UIImage(named: "logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var profileInfoVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, latitudeLabel, longitudeLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .white
//        stackView.spacing = 5
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    
    private lazy var usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
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
        view.addSubview(profileBackgroundView)
        view.addSubview(usersTableView)
        profileBackgroundView.addSubview(profileImageView)
        profileBackgroundView.addSubview(profileInfoVStack)

        NSLayoutConstraint.activate([
            profileBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            profileBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profileBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profileBackgroundView.heightAnchor.constraint(equalToConstant: 140),
            
            profileImageView.topAnchor.constraint(equalTo: profileBackgroundView.topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: profileBackgroundView.leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalTo: profileBackgroundView.heightAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalTo: profileBackgroundView.heightAnchor, constant: -20),

            profileInfoVStack.topAnchor.constraint(equalTo: profileBackgroundView.topAnchor, constant: 10),
            profileInfoVStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            profileInfoVStack.trailingAnchor.constraint(equalTo: profileBackgroundView.trailingAnchor, constant: -10),
            profileInfoVStack.bottomAnchor.constraint(equalTo: profileBackgroundView.bottomAnchor, constant: -30),

            usersTableView.topAnchor.constraint(equalTo: profileBackgroundView.bottomAnchor, constant: 30),
            usersTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            usersTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usersTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        profileBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileInfoVStack.translatesAutoresizingMaskIntoConstraints = false
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
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
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else { return UITableViewCell()}
        cell.configureCell(User(name: "Anatan", imageName: "logo", latitude: 0, longitude: 0, distanse: 12341.12))
        return cell
    }
}
