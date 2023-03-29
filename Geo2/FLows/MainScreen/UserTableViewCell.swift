//
//  UserTableViewCell.swift
//  Geo2
//
//  Created by Anton Zyabkin on 29.03.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //        print("go")
    //        // Configure the view for the selected state
    //    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
    func configureCell(_ user: User) {
        
        backgroundColor = .clear
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
    
        let view = UserInfoView(frame: frame , user: user)
        contentView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
