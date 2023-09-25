//
//  CurrencyListViewModel.swift
//  Which currency
//
//  Created by Victor on 19.09.2023.
//

import Foundation
import RxSwift

class CurrencyListViewModel {
    
    private var currencyListModel: CurrencyListModel?
    
    var listOfCurrencies: PublishSubject<[CurrencyListElement]> = PublishSubject()
    
    private let disposeBag = DisposeBag()

    
    init() {
        self.currencyListModel = CurrencyListModel()
    }
    
    func fetchCurrenciesData(didFetch: @escaping () -> Void) {
        
        currencyListModel?.getListOfCurrencies(didGet: { [weak self] valutes in
            
            guard valutes != nil else {
                didFetch()
                return
                
            }
            
            self?.listOfCurrencies.onNext(valutes!.sorted { elem1, elem2 in
                
                elem1.isFavourite && !elem2.isFavourite
                
            })
            didFetch()
            
        })
        
    }
    
    func didTapStar(_ index: Int) {
        
        
        
    }
    
}


