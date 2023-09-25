//
//  FavoriteController.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import UIKit
import RxSwift

final class FavouriteController: BaseController {
    

    var viewModel: FavouritesViewModel?
    let disposeBag = DisposeBag()

    var tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewModel = FavouritesViewModel()
        
        layoutView()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel?.fetchCurrenciesData(didFetch: {
            
        })
        
    }
    
    override func configureAppearance() {
        title = Resources.Strings.TabBar.title(for: .favourite)
    }
    
    @objc func updateCurrencies(_ sender: UIRefreshControl) {
        print("data fetching")
        viewModel?.fetchCurrenciesData {
            
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
            
        }
    }
       
    
//    func getFavoritesCurrencies() -> []
    
}
