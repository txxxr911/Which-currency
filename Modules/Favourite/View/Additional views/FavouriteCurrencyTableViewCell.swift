//
//  FavouriteCurrencyTableViewCell.swift
//  Which currency
//
//  Created by Victor on 05.09.2023.
//

import UIKit

class FavouriteCurrencyTableViewCell: UITableViewCell {
    
    let view: UIView = {
        
        let view = UIView()
        
        view.layer.cornerRadius = 15
        view.backgroundColor = Resources.Colors.currencyViewBackground
        
        return view
        
    }()
    
    let valuteLabel: UILabel = {
        
        let label = UILabel()
        label.font = Resources.Fonts.helvelticaRegular(with: 22)
        label.textColor = Resources.Colors.titleGray
        label.textAlignment = .left
        return label
    }()
    
    let currentRateLabel: UILabel = {
        
        let label = UILabel()
        label.font = Resources.Fonts.helvelticaRegular(with: 24)
        label.textColor = Resources.Colors.titleGray
        label.textAlignment = .left
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FavouriteCurrencyCellIdentifier")
        
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func bind() {
        
        backgroundColor = .clear
        
        selectionStyle = .none
        
        view.clipsToBounds = false
        
        view.layer.cornerRadius = 15
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 0.8

    }
    
    fileprivate func layout() {
        
        setupView(view)
        view.setupView(valuteLabel)
        view.setupView(currentRateLabel)
        
        NSLayoutConstraint.activate([
            
            view.heightAnchor.constraint(equalToConstant: 98),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valuteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            valuteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valuteLabel.widthAnchor.constraint(equalToConstant: 50),
            
            currentRateLabel.leadingAnchor.constraint(equalTo: valuteLabel.trailingAnchor, constant: 10),
            currentRateLabel.centerYAnchor.constraint(equalTo: valuteLabel.centerYAnchor),
            currentRateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            
        ])
        
    }
    
    func setup(valute: FavouriteValute) -> FavouriteCurrencyTableViewCell {
        
        self.valuteLabel.text = valute.charCode
        self.currentRateLabel.text = String(valute.currentValue).replacingOccurrences(of: ".", with: ",")
        
        return self
    }
}
