//
//  CalculatorModel.swift
//  Which currency
//
//  Created by Victor on 26.10.2023.
//

import Foundation
import UIKit

class CalculatorModel {
    
    enum ValueType {
        
        case first, second
        
    }
    
    private let dataFetchService: DataFetchService?
    private let dataManagerService: DataManagerService?
    
    private var firstValuteName: String = "USD"
    private var secondValuteName: String = "EUR"
    
    private var rate: Double = 54.3
    private var firstValuteValue: Double = 1
    private var secondValuteValue: Double = 1
    
    private var valutes: [Valute]?
    
    init() {
        
        self.dataFetchService = DataFetchService()
        self.dataManagerService = DataManagerService()
    }
    
    func calculateValue(valueType: ValueType) -> String {
    
        var newValue: Double
        
        switch valueType {
            
        case .first:
            
            print(secondValuteValue)
            
            newValue = round(100 * secondValuteValue * Double(rate)) / 100
            
            self.firstValuteValue = newValue
            
            print(newValue)
            
        case .second:
            newValue = round(100 * firstValuteValue / Double(rate)) / 100
            
            self.secondValuteValue = newValue
        }
        
        return convertDoubleToString(value: newValue)
    }
    
    
    private func convertDoubleToString(value: Double) -> String {
    
        return String(value).replacingOccurrences(of: ".", with: ",")
        
    }
    
    private func convertStringToDouble(string: String) -> Double {
        
        return Double(string.replacingOccurrences(of: ",", with: ".")) ?? 0
        
    }
    
   
    private func calculateRate(firstValuteName: String, secondValuteName: String) -> Double {
        
        if(firstValuteName == "RUB") {
            
            guard let secondValue = valutes?.first(where: { valute in
                
                valute.charCode == secondValuteName
                
            })?.value
                    
            else {return 0}
                        
            return secondValue
        }
        
        if(secondValuteName == "RUB") {
            
            guard let firstValue = valutes?.first(where: { valute in
                
                valute.charCode == firstValuteName
                
            })?.value
                    
            else {return 0}
            
            return 1 / firstValue
            
        }

        
        guard let firstValute = valutes?.first(where: { valute in
            
            valute.charCode == firstValuteName
            
        })
                
        else {return 0}
        
        
        guard let secondValute = valutes?.first(where: { valute in
            
            valute.charCode == secondValuteName
            
        })
                
        else {return 0}
        
        let rate = secondValute.value / firstValute.value
        
        
        return rate
    }
    
    func changeValue(valueType: ValueType, string: String) {
        
        switch valueType {
            
        case .first:
            firstValuteValue = convertStringToDouble(string: string)
            
        case .second:
            secondValuteValue = convertStringToDouble(string: string)
            
        }
    }
    
    func changeName(valueType: ValueType, name: String) {
        
        switch valueType {
            
        case .first:
            
            firstValuteName = name
            
        case .second:
            
            secondValuteName = name
            
        }
        
        self.rate = calculateRate(firstValuteName: firstValuteName, secondValuteName: secondValuteName)
                
    }
    
    func getCurrenciesList(didGet: @escaping ([String]?) -> Void) {
        
        var valuteNames: [String] = []
        
        var valutesArray = [Valute]()
        DispatchQueue.main.async {
              
            self.dataFetchService?.fetchCurrenciesRates { [weak self] valutes in
                
                
                valutes?.values.forEach { valute in
                    
                    
                    valutesArray.append(valute)
                    
                    valuteNames.append(valute.charCode)
                    
                }
        
                valuteNames.append("RUB")
                self?.valutes = valutesArray
                
                self?.rate = self?.calculateRate(firstValuteName: self?.firstValuteName ?? "USD", secondValuteName: self?.secondValuteName ?? "EUR") ?? 1
                
                didGet(valuteNames)
            }
                
        }
    }
}
