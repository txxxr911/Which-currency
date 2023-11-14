//
//  Resources.swift
//  Which currency
//
//  Created by Victor on 30.08.2023.
//

import Foundation
import UIKit

enum Resources {
    enum Colors {
        static let active = UIColor(hexString: "#437BFE")
        static let inactive = UIColor(hexString: "#929DA5")

        static let background = UIColor(hexString: "#E8E6E6")
        static let separator = UIColor(hexString: "#E8ECEF")
        static let secondary = UIColor(hexString: "#F0F3FF")

        static let currencyViewBackground = UIColor(hexString: "FEFEFE")
        
        static let titleGray = UIColor(hexString: "#545C77")
        static let favouriteStarColor = UIColor(hexString: "#FFCF48")
        
        static let textFieldBackground = UIColor(hexString: "#FFFFFF")
    }
    
    enum Strings {
        enum TabBar {
            static func title(for tab: Tabs) -> String {
                switch tab {
                case .favourite: return "Избранные"
                case .currencyList: return "Список"
                case .calculator: return "Калькулятор"
                case .settings: return "Настройки"
                }
            }
        }
        
        enum Currencies {
            static func symbol(for charCode: String) -> String {
                
                switch charCode {
                case "AUD": return "$"
                case "AZN": return "₼"
                case "GBP": return "£"
                case "AMD": return "֏"
                case "BYN": return "Br"
                case "BGN": return "лв"
                case "BRL": return "R$"
                case "HUF": return "Ft"
                case "VND": return "₫"
                case "HKD": return "HK$"
                case "GEL": return "₾"
                case "DKK": return "kr"
                case "AED": return "د.إ"
                case "USD": return "$"
                case "EUR": return "€"
                case "EGP": return "£"
                case "INR": return "₹"
                case "IDR": return "Rp"
                case "KZT": return "₸"
                case "CAD": return "$"
                case "QAR": return "﷼"
                case "KGS": return "лв"
                case "CNY": return "¥"
                case "MDL": return "L"
                case "NZD": return "$"
                case "NOK": return "kr"
                case "PLN": return "zł"
                case "RON": return "lei"
                case "XDR": return "SDR"
                case "SGD": return "$"
                case "TJS": return "ЅМ"
                case "THB": return "฿"
                case "TRY": return "₺"
                case "TMT": return "m"
                case "UZS": return "лв"
                case "UAH": return "₴"
                case "CZK": return "Kč"
                case "SEK": return "kr"
                case "CHF": return "Fr."
                case "RSD": return "дин."
                case "ZAR": return "R"
                case "KRW": return "₩"
                case "JPY": return "¥"
                default: return ""
                    
                }
            }
        }
    }

    enum Images {
        enum TabBar {
            static func icon(for tab: Tabs) -> UIImage? {
                switch tab {
                case .favourite: return UIImage(named: "favourite_tab")
                case .currencyList: return UIImage(named: "currencyList_tab")
                case .calculator: return UIImage(named: "calculator_tab")
                case .settings: return UIImage(named: "settings_tab")
                }
            }
        }
    }

    enum Fonts {
        static func helvelticaRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica", size: size) ?? UIFont()
        }
        
        static func helveticaBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Helvetica-Bold", size: size) ?? UIFont()
        }
    }
}
