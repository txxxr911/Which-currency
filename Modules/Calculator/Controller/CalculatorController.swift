//
//  CalculatorController.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import UIKit

final class CalculatorController: BaseController, UITextFieldDelegate {
    
    let firstValuteLabel: UIButton = {
        
        let button = UIButton()
        button.titleLabel?.font = Resources.Fonts.helvelticaRegular(with: 16)
        button.setTitleColor(Resources.Colors.titleGray, for: .normal)
        button.titleLabel?.textAlignment = .left
        
        return button
    }()
    
    let secondValuteLabel: UIButton = {
        
        let button = UIButton()
        button.titleLabel?.font = Resources.Fonts.helvelticaRegular(with: 16)
        button.setTitleColor(Resources.Colors.titleGray, for: .normal)
        button.titleLabel?.textAlignment = .left

        return button
    }()
    
    let firstValuteTextField: UITextField = {
        
        let textField = UITextField()
        textField.font = Resources.Fonts.helvelticaRegular(with: 16)
        textField.textColor = Resources.Colors.titleGray
        textField.textAlignment = .left
//        textField.keyboardType = .numbersAndPunctuation
        
        return textField
    }()
    
    let secondValuteTextField: UITextField = {
        
        let textField = UITextField()
        textField.font = Resources.Fonts.helvelticaRegular(with: 16)
        textField.textColor = Resources.Colors.titleGray
        textField.textAlignment = .left
        
        return textField
    }()
    
    var firstCurrencyMenu = UIMenu()
    var secondCurrencyMenu = UIMenu()
        
    let keyboardView = CalculatorKeyboard()
    
    var viewModel: CalculatorViewModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = CalculatorViewModel()
        firstValuteTextField.delegate = self
        secondValuteTextField.delegate = self
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
//        viewModel?.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.viewDidAppear()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        addTapGestureToHideKeyboard()
        
        title = Resources.Strings.TabBar.title(for: .calculator)
        
        view.setupView(keyboardView)
        view.setupView(firstValuteTextField)
        view.setupView(secondValuteTextField)
        view.setupView(firstValuteLabel)
        view.setupView(secondValuteLabel)
        
        firstValuteTextField.backgroundColor = .green
        secondValuteTextField.backgroundColor = .red
        
        firstValuteTextField.inputView = UIView()
        secondValuteTextField.inputView = UIView()
        
        firstValuteTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        secondValuteTextField.addTarget(self, action: #selector(textFieldDidEdit), for: .editingChanged)
        
        firstValuteLabel.setTitle("USD", for: .normal)

        secondValuteLabel.setTitle("EUR", for: .normal)

        
        firstValuteLabel.menu = UIMenu()
        firstValuteLabel.showsMenuAsPrimaryAction = true
        
        secondValuteLabel.menu = UIMenu()
        secondValuteLabel.showsMenuAsPrimaryAction = true
        
        keyboardView.buttonPressed = { [weak self] key in
            
            self?.handleInput(key: key)
            
        }
        
        
        
//        firstValuteTextField.inputView = keyboardView
        
        NSLayoutConstraint.activate([
            
            firstValuteTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            firstValuteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            firstValuteTextField.widthAnchor.constraint(equalToConstant: 90),
            
            secondValuteTextField.topAnchor.constraint(equalTo: firstValuteTextField.bottomAnchor, constant: 50),
            secondValuteTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            secondValuteTextField.widthAnchor.constraint(equalToConstant: 90),
            
            
            firstValuteLabel.centerYAnchor.constraint(equalTo: firstValuteTextField.centerYAnchor),
            firstValuteLabel.widthAnchor.constraint(equalToConstant: 60),
            firstValuteLabel.trailingAnchor.constraint(equalTo: firstValuteTextField.leadingAnchor, constant: -60),

            secondValuteLabel.centerYAnchor.constraint(equalTo: secondValuteTextField.centerYAnchor),
            secondValuteLabel.widthAnchor.constraint(equalToConstant: 60),
            secondValuteLabel.trailingAnchor.constraint(equalTo: secondValuteTextField.leadingAnchor, constant: -60),
            
            keyboardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            //keyboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            //keyboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            keyboardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            keyboardView.widthAnchor.constraint(equalToConstant: 240),
            keyboardView.heightAnchor.constraint(equalToConstant: 320)
            
        ])
    }
    
    private func handleInput(key: String) {
        
        
        // Determine which text field is active and append or delete text accordingly
        if let activeTextField = view.findFirstResponder() as? UITextField {
            if key == "⌫" {
                // Handle backspace
                activeTextField.deleteBackward()
            }
            
            else if key == "," {
                
                if !(activeTextField.text?.contains(",") ?? false) {
                    activeTextField.insertText(key)
                }
                
            }
            
            else {
                // Handle normal key
                activeTextField.insertText(key)
            }
        }
    }
    
    @objc func textFieldDidEdit(textField: UITextField) {
        
        if textField == firstValuteTextField {
            
            viewModel?.firstCurrencyValue.onNext(textField.text ?? "")
            viewModel?.firstCurrencyValueDidChange(to: textField.text ?? "")
            print("gig")
        }
        
        else {
            viewModel?.secondCurrencyValue.onNext(textField.text ?? "")
            viewModel?.secondCurrencyValueDidChange(to: textField.text ?? "")
            print("gag")
        }
        
    }
    
}


// Helper extension to find the first responder in the view hierarchy
private extension UIView {
    func findFirstResponder() -> UIResponder? {
        if self.isFirstResponder {
            return self
        }
        for subView in self.subviews {
            if let responder = subView.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}

extension UIViewController {
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
}

    
