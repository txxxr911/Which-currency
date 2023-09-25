//
//  CurrencyListBindings.swift
//  Which currency
//
//  Created by Victor on 19.09.2023.
//

import Foundation
import UIKit

extension CurrencyListController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = CurrencyListTableViewCell()
//            .addChangeCondition {
//                [weak self] in
//                self?.toggleFavouriteCurrency(index: indexPath.row)
//            }
//            .setup(symbol: "$", rate: "126,1", name: "Грязная зеленая бумажка", isFavourited: true)
        
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
//        cell.setup(symbol: "$", rate: "126,1", name: "Грязная зеленая бумажка", isFavourited: true)
        
        return cell
    }
    
    
    func bind() {
        
        viewModel?.listOfCurrencies
            .subscribe(onNext: { currencies in
                print("Updated currencies:", currencies)
            })
            .disposed(by: disposeBag)
        
        view.backgroundColor = Resources.Colors.background
                
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: "CurrencyListTableViewCell")
     
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel?.listOfCurrencies.bind(to: tableView.rx.items(cellIdentifier: "CurrencyListTableViewCell", cellType:  CurrencyListTableViewCell.self)) {
            (row, item, cell) in
            
            cell.setup(symbol: item.charCode, rate: item.currentValue, name: item.valuteName, isFavourited: item.isFavourite)
            cell.addChangeCondition {
                [weak self] in
                self?.toggleFavouriteCurrency(index: row)
            }
        }.disposed(by: disposeBag)
        
        tableView.showsVerticalScrollIndicator = false
    }
    
}
