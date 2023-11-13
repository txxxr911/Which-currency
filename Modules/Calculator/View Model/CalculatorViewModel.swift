//
//  CalculatorViewModel.swift
//  Which currency
//
//  Created by Victor on 08.11.2023.
//

import Foundation
import RxSwift


class CalculatorViewModel {
    
    private var calculatorModel: CalculatorModel?
    
    var currenciesList: PublishSubject<[String]> = PublishSubject()
    
    var firstCurrencyName: PublishSubject<String> = PublishSubject()
    var secondCurrencyName: PublishSubject<String> = PublishSubject()
    
    var firstCurrencyValue: PublishSubject<String> = PublishSubject()
    var secondCurrencyValue: PublishSubject<String> = PublishSubject()
    
    var disposeBag = DisposeBag()
        
    
    init() {
        
        self.calculatorModel = CalculatorModel()
        
    }
    
    func viewDidAppear() {
        
        calculatorModel?.getCurrenciesList { [weak self] valuteList in
            
            self?.currenciesList.onNext(valuteList ?? [])
            
        }
        
    }
    
    func firstCurrencyNameDidChange(to name: String) {
        
        guard let calculatorModel else {return}
        
        firstCurrencyName.onNext(name)
        calculatorModel.changeName(valueType: .first, name: name)
        secondCurrencyValue.onNext(calculatorModel.calculateValue(valueType: .second))
        
    }
    
    func secondCurrencyNameDidChange(to name: String) {
        
        guard let calculatorModel else {return}
        
        secondCurrencyName.onNext(name)
        calculatorModel.changeName(valueType: .second, name: name)
        firstCurrencyValue.onNext(calculatorModel.calculateValue(valueType: .first))
    }
    
    func firstCurrencyValueDidChange(to value: String) {
        
        guard let calculatorModel else {return}
        
        calculatorModel.changeValue(valueType: .first, string: value)
        
        secondCurrencyValue.onNext(calculatorModel.calculateValue(valueType: .second))
        

    }
    
    
    func secondCurrencyValueDidChange(to value: String) {
        
        guard let calculatorModel else {return}
        
        calculatorModel.changeValue(valueType: .second, string: value)
        firstCurrencyValue.onNext(calculatorModel.calculateValue(valueType: .first))
        
    }
}
