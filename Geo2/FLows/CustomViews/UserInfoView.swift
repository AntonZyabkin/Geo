//
//  UserInfoView.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import UIKit
import MapKit

class UserInfoView: UIView {
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        let image = UIImage(named: "logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var userInfoVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, distanceLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .clear
        stackView.spacing = 5
        return stackView
    }()
    
    
    init(frame: CGRect, user: User) {
        super.init(frame: frame)
        configSubviews(user: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configSubviews(user: User) {
        logoImageView.image = UIImage(named: user.imageName)
        userNameLabel.text = user.name
        distanceLabel.text =  String(format:  "Distanse: %.01f km", user.distanse/1000)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(logoImageView)
        addSubview(userInfoVStack)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImageView.heightAnchor.constraint(equalTo: heightAnchor),
            logoImageView.widthAnchor.constraint(equalTo: heightAnchor),

            userInfoVStack.topAnchor.constraint(equalTo: topAnchor),
            userInfoVStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            userInfoVStack.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),
            userInfoVStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        userInfoVStack.translatesAutoresizingMaskIntoConstraints = false
    }
}
