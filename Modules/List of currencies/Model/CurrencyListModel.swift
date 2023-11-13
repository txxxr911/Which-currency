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
    
    var favouriteCurrenciesCharCodes: [String] = []
    
    var currencyList: [CurrencyListElement]?
    
    
    init() {
        
        self.dataFetchService = DataFetchService()
        self.dataManagerService = DataManagerService()
        
        self.favouriteCurrenciesCharCodes = self.dataManagerService?.getFavouritesCurrencies() ?? []
        
        self.markFavouritesValutes()
        
        self.updateFavouritesDataArray()
        
        self.sortCurrenciesByFavourites()
        
        
    }
    
    func markFavouritesValutes() {
        
        var favouriteCurrenciesDict: [String:Bool] = [:]
        
        self.favouriteCurrenciesCharCodes.forEach({ charCode in
            
            favouriteCurrenciesDict[charCode] = true
            
        })
        
        guard let currencyListCount = self.currencyList?.count else {return}
        
        for index in 0..<currencyListCount {
            
            let element = currencyList?[index]
            
            if let isFavourite = favouriteCurrenciesDict[element?.charCode ?? ""] {
                
                currencyList?[index].isFavourite = isFavourite
                
            }
            
            else {
                
                currencyList?[index].isFavourite = false
            }
            
        }
        
    }
    
    func sortCurrenciesByFavourites() {
        
        self.currencyList = self.currencyList?.sorted(by: { elem1, elem2 in
            
            elem1.isFavourite && !elem2.isFavourite
            
        })
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
                
                let valuteElement = CurrencyListElement(charCode: valute.charCode, currentValue: String(valute.value), valuteName: valute.name, isFavourite: self.checkCurrencyIsFavourite(valuteCharCode: valute.charCode))
                
                currencyList.append(valuteElement )
            })
            
            self.currencyList = currencyList
            self.sortCurrenciesByFavourites()
            
            didGet(self.currencyList)
            
        }
        
    }
    
    func checkCurrencyIsFavourite(valuteCharCode: String) -> Bool {
        
        self.favouriteCurrenciesCharCodes.contains(valuteCharCode)
        
    }
    
    func toggleCurrencyFavourite(index: Int, didToggle: @escaping ([CurrencyListElement]?) -> Void) {
        
        switch(self.currencyList?[index].isFavourite) {
            
        case true:
            
            
            self.favouriteCurrenciesCharCodes.removeAll { string in
                string == self.currencyList?[index].charCode ?? ""
            }
            
            break;
            
            
        case false:
            
            
            self.favouriteCurrenciesCharCodes.append(self.currencyList?[index].charCode ?? "")
            break;

        case .none:
            return
        case .some(_):
            return
        }
        
        self.currencyList?[index].isFavourite.toggle()
    
        self.sortCurrenciesByFavourites()
       
        
        self.dataManagerService?.saveFavouritesCurrencies(self.favouriteCurrenciesCharCodes)
        
        
        didToggle(currencyList)
    }
    
}

struct CurrencyListElement {
    
    var charCode: String
    var currentValue: String
    var valuteName: String
    var isFavourite: Bool
    
}
