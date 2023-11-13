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
    
    let arrowImageView: UIImageView = {
        
        let imageView = UIImageView()
        
//        image.renderingMode = .alwaysTemplate
//        image.size.width = 50
//        image.size.height = 50
        
        
        
        return imageView
        
    }()
    
    let rateChangingLabel: UILabel = {
        
        let label = UILabel()
        label.font = Resources.Fonts.helvelticaRegular(with: 14)
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
        view.setupView(arrowImageView)
        view.setupView(rateChangingLabel)
        
        
        NSLayoutConstraint.activate([
            
            view.heightAnchor.constraint(equalToConstant: 98),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            valuteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            valuteLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            valuteLabel.widthAnchor.constraint(equalToConstant: 50),
            
            currentRateLabel.leadingAnchor.constraint(equalTo: valuteLabel.trailingAnchor, constant: 10),
            currentRateLabel.centerYAnchor.constraint(equalTo: valuteLabel.centerYAnchor),
            currentRateLabel.widthAnchor.constraint(equalToConstant: 100),
//            currentRateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            arrowImageView.topAnchor.constraint(equalTo: currentRateLabel.bottomAnchor, constant: 10),
            arrowImageView.leadingAnchor.constraint(equalTo: currentRateLabel.leadingAnchor, constant: 20),
            arrowImageView.widthAnchor.constraint(equalToConstant: 15),
            arrowImageView.heightAnchor.constraint(equalToConstant: 15),
            
            rateChangingLabel.topAnchor.constraint(equalTo: currentRateLabel.bottomAnchor),
            rateChangingLabel.leadingAnchor.constraint(equalTo: arrowImageView.trailingAnchor),
            rateChangingLabel.centerYAnchor.constraint(equalTo: arrowImageView.centerYAnchor),
            rateChangingLabel.widthAnchor.constraint(equalToConstant: 150),
            rateChangingLabel.heightAnchor.constraint(equalToConstant: 150),
            
            
        ])
        
    }
    
    func setup(valute: FavouriteValute) -> FavouriteCurrencyTableViewCell {
        
        self.valuteLabel.text =  Resources.Strings.Currencies.symbol(for: valute.charCode)
        self.currentRateLabel.text = String(valute.currentValue).replacingOccurrences(of: ".", with: ",")
        
        self.rateChangingLabel.text = String(defineRateChanging(currentRate: valute.currentValue, lastRate: valute.lastValue)) + "%"
        self.rateChangingLabel.textColor = defineColor(currentRate: valute.currentValue, lastRate: valute.lastValue) ? .green : .red
        
        self.arrowImageView.image = defineImage(currentRate: valute.currentValue, lastRate: valute.lastValue)
        
        return self
    }
    
    private func defineImage(currentRate: Double, lastRate: Double) -> UIImage? {
        
        if currentRate > lastRate {
            
            return UIImage(named: "arrowBottom")
            
        }
        
        else {
            
            return UIImage(named: "arrowTop")
            
        }
        
    }
    
    private func defineRateChanging(currentRate: Double, lastRate: Double) -> Double {
        
        let percent = currentRate / 100
        
        let rateChanging = abs(currentRate - lastRate)
        
        let percentChanging = (rateChanging / percent)
        
        let roundedPercent = round(100 * percentChanging) / 100
        
        return roundedPercent
    }
    
    private func defineColor(currentRate: Double, lastRate: Double) -> Bool {
        
        currentRate > lastRate ? false : true
        
    }
}
