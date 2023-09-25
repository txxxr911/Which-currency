//
//  FavouriteControllerLayout.swift
//  Which currency
//
//  Created by Victor on 05.09.2023.
//

import UIKit

extension FavouriteController {
        
    func layoutView() {
        
        view.setupView(tableView)
        
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 26),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
    }
}
