//
//  DataManagerService.swift
//  Which currency
//
//  Created by Victor on 14.09.2023.
//

import Foundation

class DataManagerService {
        
    private var shouldUpdateData: Bool = false
    
    func getFavouritesCurrencies() -> [String] {
        
        // Retrieve the saved favourite currencies from UserDefaults
        if let currencies = UserDefaults.standard.array(forKey: "FavouriteCurrencies") as? [String] {
            return currencies
        }
        return []
    }
        
    // Save the string array of favourite currencies
    func saveFavouritesCurrencies(_ currencies: [String]) {
    // Save the favourite currencies to UserDefaults
        UserDefaults.standard.set(currencies, forKey: "FavouriteCurrencies")
    }
    
}
