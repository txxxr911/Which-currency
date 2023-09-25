//
//  TabBarController.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import UIKit

enum Tabs: Int {
    case favourite
    case currencyList
    case calculator
    case settings
}

final class TabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        tabBar.tintColor = Resources.Colors.active
        tabBar.barTintColor = Resources.Colors.inactive
        
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = Resources.Colors.separator.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let favouriteController = FavouriteController()
        let currencyListController = CurrencyListController()
        let calculatorController = CalculatorController()
        let settingsController = SettingsController()
        
        let favouriteNavigation = NavBarController(rootViewController: favouriteController)
        let currencyListNavigation = NavBarController(rootViewController: currencyListController)
        let calculatorNavigation = NavBarController(rootViewController: calculatorController)
        let settingsNavigation = NavBarController(rootViewController: settingsController)
        
        favouriteNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.title(for: .favourite), image: Resources.Images.TabBar.icon(for: .favourite), tag: Tabs.favourite.rawValue)
        currencyListNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.title(for: .currencyList), image: Resources.Images.TabBar.icon(for: .currencyList), tag: Tabs.currencyList.rawValue)
        calculatorNavigation.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.title(for: .calculator), image: Resources.Images.TabBar.icon(for: .calculator), tag: Tabs.calculator.rawValue)
        settingsController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.title(for: .settings), image: Resources.Images.TabBar.icon(for: .settings), tag: Tabs.settings.rawValue)
        
        // MARK: make function to do it
        self.tabBar.barTintColor = .none
        
        setViewControllers([
            favouriteNavigation,
            currencyListNavigation,
            calculatorNavigation,
            settingsNavigation], animated: false)
        
    }
    
}
