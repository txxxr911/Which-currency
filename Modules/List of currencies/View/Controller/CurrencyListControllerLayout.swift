//
//  CurrencyListControllerLayout.swift
//  Which currency
//
//  Created by Victor on 19.09.2023.
//

import UIKit

extension CurrencyListController {
    
    func layoutView() {
        
        view.setupView(tableView)
                
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
        
    }
    
}
