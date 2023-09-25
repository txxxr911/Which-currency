//
//  CurrencyListViewCell.swift
//  Which currency
//
//  Created by Victor on 19.09.2023.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    
    let view: UIView = {
        
        let view = UIView()
        
        view.backgroundColor = Resources.Colors.currencyViewBackground
        
        return view
        
    }()
    
    let valuteLabel: UILabel = {
        
        let label = UILabel()
        label.font = Resources.Fonts.helvelticaRegular(with: 14)
        label.textColor = Resources.Colors.titleGray
        label.textAlignment = .left
        return label
    }()
    
    let valuteNameLabel: UILabel = {
        
        let label = UILabel()
        label.font = Resources.Fonts.helvelticaRegular(with: 12)
        label.textColor = Resources.Colors.titleGray
        label.textAlignment = .left
        return label
    }()
    
    let currentRateLabel: UILabel = {
        
        let label = UILabel()
        label.font = Resources.Fonts.helvelticaRegular(with: 14)
        label.textColor = Resources.Colors.titleGray
        label.textAlignment = .left
        return label
    }()
    
    let favouriteButton: UIButton = {
        
        let button = UIButton()
        
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        return button
        
    }()
    
    var changeCondition: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CurrencyListCellIdentifier")
        
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func bind() {
        
        selectionStyle = .none
        
        backgroundColor = .clear
        
        view.clipsToBounds = false
        
    }
    
    fileprivate func layout() {
        
        setupView(view)
        view.setupView(valuteLabel)
        view.setupView(valuteNameLabel)
        view.setupView(currentRateLabel)
        
        contentView.setupView(favouriteButton)
        
        NSLayoutConstraint.activate([
            
            view.heightAnchor.constraint(equalToConstant: 40),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valuteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            valuteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valuteLabel.widthAnchor.constraint(equalToConstant: 25),
            
            currentRateLabel.leadingAnchor.constraint(equalTo: valuteLabel.trailingAnchor, constant: 15),
            currentRateLabel.centerYAnchor.constraint(equalTo: valuteLabel.centerYAnchor),
            currentRateLabel.widthAnchor.constraint(equalToConstant: 60),
            
            valuteNameLabel.leadingAnchor.constraint(equalTo: currentRateLabel.trailingAnchor, constant: 15),
            valuteNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valuteNameLabel.widthAnchor.constraint(equalToConstant: 180),
            
            favouriteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            favouriteButton.widthAnchor.constraint(equalToConstant: 30),
            favouriteButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    func setup(symbol: String, rate: String, name: String, isFavourited: Bool)  -> CurrencyListTableViewCell {
                
        self.valuteLabel.text = Resources.Strings.Currencies.symbol(for: symbol)
        
        self.currentRateLabel.text = rate
        
        self.valuteNameLabel.text = name
        
        self.favouriteButton.tintColor = isFavourited ? Resources.Colors.favouriteStarColor : .gray
        self.favouriteButton.addTarget(self, action: #selector(changeConditionButtonDidTap), for: .touchUpInside)
        
        
        return self
    }
    
    @objc func changeConditionButtonDidTap(_ sender: UIButton) {
        changeCondition?()
    }
}

extension CurrencyListTableViewCell {
    
    func addChangeCondition(condition: @escaping () -> Void) -> CurrencyListTableViewCell {
        changeCondition = condition
        return self
    }
    
}
