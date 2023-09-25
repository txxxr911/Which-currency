//
//  SettingsController.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import UIKit

final class SettingsController: BaseController {
    
    
    override func configureAppearance() {
        super.configureAppearance()
        
        title = Resources.Strings.TabBar.title(for: .settings)
//        tabBarController?.tabBarItem.title = Resources.Strings.TabBar.title(for: .calculator)
    }
    
}
