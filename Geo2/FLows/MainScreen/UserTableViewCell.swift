//
//  UserTableViewCell.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"
    var userInfoView = UserInfoView(frame: .zero , user: User())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0))
    }
    
    func configureCell() {
        backgroundColor = .clear
        contentView.addSubview(userInfoView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        NSLayoutConstraint.activate([
            userInfoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            userInfoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userInfoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            userInfoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        userInfoView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func updateCell(_ user: User) {
        userInfoView.configSubviews(user: user)
    }
}
