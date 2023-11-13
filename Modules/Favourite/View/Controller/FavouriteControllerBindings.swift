//
//  FavouriteControllerBindings.swift
//  Which currency
//
//  Created by Victor on 05.09.2023.
//

import UIKit
import RxCocoa
import RxSwift


extension FavouriteController: UITableViewDelegate, UITableViewDataSource {
 
    func bind() {
        
        viewModel?.favoritesCurrencies
            .subscribe(onNext: { currencies in
                // Update your UI or perform other actions with the updated currency data
            
            })
            .disposed(by: disposeBag)
        
        view.backgroundColor = Resources.Colors.background
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none

        tableView.register(FavouriteCurrencyTableViewCell.self, forCellReuseIdentifier: "FavouriteCurrencyCellIdentifier")
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel?.favoritesCurrencies.bind(to: tableView.rx.items(cellIdentifier: "FavouriteCurrencyCellIdentifier", cellType: FavouriteCurrencyTableViewCell.self)) {
            (row, item, cell) in

            cell.setup(valute: item)
            
        }.disposed(by: disposeBag)
        
        tableView.showsVerticalScrollIndicator = false

        
        // Create a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateCurrencies), for: .valueChanged)

        // Add the refresh control to the table view
        tableView.refreshControl = refreshControl
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell = UITableViewCell()
        let cell = FavouriteCurrencyTableViewCell()
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        let valute = FavouriteValute(charCode: "$", currentValue: 96.12, lastValue: 96.10)
        
        return cell.setup(valute: valute)
        
    }
    
}
