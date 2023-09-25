//
//  BaseController.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        constraintViews()
        configureAppearance()
    }
}

@objc extension BaseController {

    func setupViews() {}
    func constraintViews() {}

    func configureAppearance() {
        view.backgroundColor = Resources.Colors.background
    }
}
