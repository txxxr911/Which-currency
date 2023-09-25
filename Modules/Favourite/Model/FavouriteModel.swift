//
//  Currency.swift
//  Which currency
//
//  Created by Victor on 03.09.2023.
//

import Foundation

class FavouriteModel {
        
    private let dataFetchService: DataFetchService?
    private let dataManagerService: DataManagerService?
    
    // потом поменять на пустой массив
    var favouriteCurrenciesCharCodes = ["EUR", "USD"]
    
    var favouriteCurrencies: [FavouriteValute] = [FavouriteValute]()
    
    init() {
        
        self.dataFetchService = DataFetchService()
        self.dataManagerService = DataManagerService()
        
        self.updateFavouritesDataArray()
        
    }
    
    private func updateFavouritesDataArray() {
        
        self.favouriteCurrenciesCharCodes = dataManagerService?.getFavouritesCurrencies() ?? []
        
    }
    
    func getFavouriteCurrenciesRates(didGet: @escaping ([FavouriteValute]?) -> Void) {
        
        self.updateFavouritesDataArray()
        
        fetchExchangeRates { [weak self] result in
            
            didGet(self?.filterFavouriteCurrencies(currencies: result))
            
        }
        
    }
    
    
    private func fetchExchangeRates(didFetch: @escaping ([String:Valute]?) -> Void ) {
        
        dataFetchService?.fetchCurrenciesRates(didGet: { result in
            
            didFetch(result)
            
        })
       
    }
    
    private func filterFavouriteCurrencies(currencies: [String:Valute]?) -> [FavouriteValute]? {
        
        guard let currencies = currencies else {
            return nil
        }
        
        let filteredValutes = currencies
            .filter { favouriteCurrenciesCharCodes.contains($0.key) }
            .map { (charCode, valute) in
                return FavouriteValute(charCode: charCode,
                                       currentValue: valute.value,
                                       lastValue: valute.previous)
            }
        let sortedValutes = filteredValutes.sorted { valute1, valute2 in
            guard let index1 = favouriteCurrenciesCharCodes.firstIndex(of: valute1.charCode),
                  let index2 = favouriteCurrenciesCharCodes.firstIndex(of: valute2.charCode) else {
                
                return false // Handle the case where charCode is not found in the array
            }
            return index1 < index2
        }
           
           return sortedValutes.isEmpty ? nil : sortedValutes
    }
    
    private func addCurrencyToFavourites() {
        
    }
    
    private func removeCurrencyFromFavourites() {
        
    }
    
    private func saveCurrentCurrenciesRateToMemory() {
        
    }
    
}

struct FavouriteValute {
    
    var charCode: String
    var currentValue: Double
    var lastValue: Double
    
//    var previousValues: []
}
