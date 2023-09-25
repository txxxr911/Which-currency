//
//  FavouritesViewModel.swift
//  Which currency
//
//  Created by Victor on 03.09.2023.
//

import Foundation
import RxSwift

class FavouritesViewModel {
    
    private let disposeBag = DisposeBag()

    var favoritesCurrencies: PublishSubject<[FavouriteValute]> = PublishSubject()
    
    var favouriteModel: FavouriteModel?
        
    
    init() {
        
        self.favouriteModel = FavouriteModel()
    }

    
    
    func fetchCurrenciesData(didFetch: @escaping() -> Void) {
        
        favouriteModel?.getFavouriteCurrenciesRates(didGet: { [weak self] valutes in
            
            guard valutes != nil else {
                didFetch()
                return
                
            }
            
            self?.favoritesCurrencies.onNext(valutes!)
            didFetch()
            
        })
        
    }
    
}
