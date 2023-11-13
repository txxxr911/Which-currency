//
//  DataFetchService.swift
//  Which currency
//
//  Created by Victor on 14.09.2023.
//

import Foundation

final class DataFetchService {
    
    let url = URL(string: "https://www.cbr-xml-daily.ru/daily_json.js")!
    
    func fetchCurrenciesRates(didGet: @escaping ([String: Valute]?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                didGet(nil)
                return
            }
            
            guard data != nil else {
                didGet(nil)
                return
            }
            
            do {
                let response = try self.decodeCurrencyResponse(from: data)
                didGet(response?.valute)
            }
            
            catch {
                print("Error decoding currency response:", error)
                didGet(nil)
            }
            
            
        }
        
        task.resume()
        
    }
    
    
    private func decodeCurrencyResponse(from data: Data?) throws -> CurrencyResponse? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard data != nil else {
            return nil
        }
        
        return try decoder.decode(CurrencyResponse.self, from: data!)
    }
    
}

struct Valute: Decodable {
    
    let id: String
    let numCode: String
    let charCode: String
    let nominal: Int
    let name: String
    let value: Double
    let previous: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }

}
