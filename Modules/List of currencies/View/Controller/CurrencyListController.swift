//
//  CurrencyListController.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import UIKit
import RxSwift


final class CurrencyListController: BaseController {
    
    var viewModel: CurrencyListViewModel?
    let disposeBag = DisposeBag()

    
    var tableView = UITableView()
    
    
//    let button: UIButton = {
//        
//        let button = UIButton()
//        
//        button.setTitle("add dirty green valute and eur", for: .normal)
//        button.backgroundColor = .blue
//        
//        button.addTarget(self, action: #selector(save), for: .touchUpInside)
//        return button
//    }()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = CurrencyListViewModel()
        
        self.bind()
        self.layoutView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel?.fetchCurrenciesData(didFetch: {
            
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func save() {
        
        UserDefaults.standard.set(["USD", "EUR", "AUD"], forKey: "FavouriteCurrencies")
    }
    
    func toggleFavouriteCurrency(index: Int) {
        
        viewModel?.didTapStar(index: index)
        print("tapped button \(index)")
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        title = Resources.Strings.TabBar.title(for: .currencyList)
        
//        view.setupView(button)
//
//        NSLayoutConstraint.activate([
//
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            button.widthAnchor.constraint(equalTo: view.widthAnchor),
//            button.heightAnchor.constraint(equalToConstant: 50)
//
//        ])
    }
    
}
