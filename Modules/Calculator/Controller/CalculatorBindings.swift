//
//  CalculatorBindings.swift
//  Which currency
//
//  Created by Victor on 26.10.2023.
//

import Foundation
import RxSwift

extension CalculatorController {
    
    func bind() {
        
        viewModel?.firstCurrencyValue.subscribe { [weak self] event in
            
            print(event.element)
            self?.firstValuteTextField.text = event.element
            
        }.disposed(by: viewModel!.disposeBag)
        
        viewModel?.secondCurrencyValue.subscribe { [weak self] event in
            
            print(event.element)
            self?.secondValuteTextField.text = event.element
            
        }.disposed(by: viewModel!.disposeBag)
        
        
        viewModel?.firstCurrencyName.subscribe { [weak self] event in
            
            print(event.element)
            self?.firstValuteLabel.setTitle(event.element, for: .normal)
            
        }.disposed(by: viewModel!.disposeBag)
        
        viewModel?.secondCurrencyName.subscribe { [weak self] event in
            print(event.element)
            self?.secondValuteLabel.setTitle(event.element, for: .normal)
            
        }.disposed(by: viewModel!.disposeBag)
        
        
        viewModel?.currenciesList.subscribe { [weak self] event in
            
            var childrensFirst = [UIAction]()
            var childrensSecond = [UIAction]()
            
            event.element?.forEach { valute in
                
                let actionFirst = UIAction(title: valute) { _ in
                    
                    self?.viewModel?.firstCurrencyNameDidChange(to: valute)
                    print(valute)
                }
                
                let actionSecond = UIAction(title: valute) { _ in
                    
                    self?.viewModel?.secondCurrencyNameDidChange(to: valute)
                    print(valute)
                }
                
                childrensFirst.append(actionFirst)
                childrensSecond.append(actionSecond)
            }
            
            DispatchQueue.main.async {
                self?.firstValuteLabel.menu = UIMenu(title: "Primary", children: childrensFirst)
                self?.secondValuteLabel.menu = UIMenu(title: "Secondary", children: childrensSecond)
            }
            
            
        }.disposed(by: viewModel!.disposeBag)
    }
    
}
