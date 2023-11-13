//
//  CalculacorKeyboardView.swift
//  Which currency
//
//  Created by Victor on 07.11.2023.
//

import UIKit

class CalculatorKeyboard: UIView {
    
    let buttonTitles = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ",", "0", "⌫"]
    
    var buttonPressed: ((String) -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupButtons()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButtons()
    }
    
    private func setupButtons() {
        
        var buttons = [UIButton]()
        
        for title in buttonTitles {
            
            let button = UIButton(type: .system)
            
            button.setTitle(title, for: .normal)
            button.addTarget(self, action: #selector(keyPressed(_:)), for: .touchUpInside)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 36)
            buttons.append(button)
        }
        
        layoutButtons(buttons: buttons)
        
    }
    
    private func layoutButtons(buttons: [UIButton]) {
        
        var counter = 0
        var row = 0
        
        var constraints = [NSLayoutConstraint]()
        
        buttons.forEach { button in
            
            setupView(button)
            
            let buttonLeadingConstraint = button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat((80 * counter)))
            let buttonTopConstraint = button.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat((80 * row)))
            
            let buttonWidthConstraint = button.widthAnchor.constraint(equalToConstant: 80)
            let buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: 80)
            
            if counter < 2 {
                counter += 1
            }
        
            else {
                counter = 0
                
                row += 1
            }
            
            constraints.append(buttonLeadingConstraint)
            constraints.append(buttonTopConstraint)
            constraints.append(buttonWidthConstraint)
            constraints.append(buttonHeightConstraint)
        }
       
        NSLayoutConstraint.activate(constraints)
        
    }

    @objc func keyPressed(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            buttonPressed?(title)
        }
    }
}
