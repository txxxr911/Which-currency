//
//  ServiceStructs.swift
//  Which currency
//
//  Created by Victor on 14.09.2023.
//

import Foundation

struct CurrencyResponse: Decodable {
    let date: String
    let previousDate: String
    let previousURL: String
    let timestamp: String
    let valute: [String: Valute]
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case previousURL = "PreviousURL"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}
