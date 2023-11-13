//
//  CurrencyListViewModelProtocol.swift
//  Which currency
//
//  Created by Victor on 26.10.2023.
//

import Foundation
import RxSwift

protocol CurrencyListViewModelProtocol {
    
    var listOfCurrencies: PublishSubject<[CurrencyListElement]> { get }
    var disposeBag: DisposeBag { get }
    
    func didTapStar(index: Int)
    
}
