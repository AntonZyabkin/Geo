//
//  PinedUserView.swift
//  Geo2
//
//  Created by Anton Zyabkin on 30.03.2023.
//

import Foundation
import UIKit

class PinedUserView: UIView {
    
    var view: UserInfoView
    
    init(frame: CGRect, user: User) {
        view = UserInfoView(frame: .zero, user: user)
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    func configSubviews(user: User) {
        view.configSubviews(user: user)
    }
}
