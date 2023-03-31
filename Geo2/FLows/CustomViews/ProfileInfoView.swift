//
//  ProfileInfoView.swift
//  Geo2
//
//  Created by Anton Zyabkin on 30.03.2023.
//

import UIKit

class ProfileInfoView: UIView {
    var name: String
    var latitude: Double
    var longitude: Double
    var image: UIImage
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Name: \(name)"
        return label
    }()
    private lazy var latitudeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    private lazy var longitudeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
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
        stackView.layer.cornerRadius = 15
        return stackView
    }()

    init(frame: CGRect, name: String, latitude: Double, longitude: Double, imageName: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.image = UIImage(named: imageName) ?? UIImage()
        super.init(frame: frame)
        self.changeCoordinates(latitude: latitude, longitude: longitude)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        configSubviews()
    }
    
    func changeCoordinates(latitude: Double, longitude: Double) {
        latitudeLabel.text = String(format:  "Latitude: %.02f°", latitude)
        longitudeLabel.text = String(format:  "Longitude: %.02f°", longitude)
    }
    private func configSubviews() {
        addSubview(profileImageView)
        addSubview(profileInfoVStack)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -20),
            profileImageView.widthAnchor.constraint(equalTo: heightAnchor, constant: -20),
            
            profileInfoVStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            profileInfoVStack.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 20),
            profileInfoVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            profileInfoVStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileInfoVStack.translatesAutoresizingMaskIntoConstraints = false
    }
}
