//
//  NavBarController.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import UIKit

final class NavBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAppearance()
    }

    private func configureAppearance() {
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: Resources.Colors.titleGray,
            .font: Resources.Fonts.helvelticaRegular(with: 17)
        ]

        navigationBar.addBottomBorder(with: Resources.Colors.separator, height: 1)
    }
}
