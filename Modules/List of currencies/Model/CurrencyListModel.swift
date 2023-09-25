//
//  CurrencyListModel.swift
//  Which currency
//
//  Created by Victor on 19.09.2023.
//

import Foundation

class CurrencyListModel {
    
    private let dataFetchService: DataFetchService?
    private let dataManagerService: DataManagerService?
    
    var favouriteCurrenciesCharCodes = ["EUR", "USD"]
    
    var currencyList: [CurrencyListElement]?
    
    
    init() {
        
        self.dataFetchService = DataFetchService()
        self.dataManagerService = DataManagerService()
        
        self.updateFavouritesDataArray()
        
        
    }
    
    func updateListOfCurrencies() {
        self.getListOfCurrencies { result in
            self.currencyList = result
        }
    }
    
    private func updateFavouritesDataArray() {
        
        self.favouriteCurrenciesCharCodes = dataManagerService?.getFavouritesCurrencies() ?? []
        
    }
    
    func fetchCurrenciesRates(didFetch: @escaping ([String:Valute]?) -> Void) {
        
        dataFetchService?.fetchCurrenciesRates(didGet: { result in
            
            didFetch(result)
            
        })
        
    }
    
    func getListOfCurrencies(didGet: @escaping ([CurrencyListElement]?) -> Void) {
        
        self.fetchCurrenciesRates { valutes in
            
            var currencyList = [CurrencyListElement]()
            
            valutes?.values.forEach({ valute in
                
                var valuteElement = CurrencyListElement(charCode: valute.charCode, currentValue: String(valute.value), valuteName: valute.name, isFavourite: self.checkCurrencyIsFavourite(valuteCharCode: valute.charCode))
                
                currencyList.append(valuteElement )
            })
            
            didGet(currencyList)
            
        }
        
    }
    
    func checkCurrencyIsFavourite(valuteCharCode: String) -> Bool {
        
        self.favouriteCurrenciesCharCodes.contains(valuteCharCode)
        
    }
    
    
}

struct CurrencyListElement {
    
    var charCode: String
    var currentValue: String
    var valuteName: String
    var isFavourite: Bool
    
}
