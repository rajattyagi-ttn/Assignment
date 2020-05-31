//
//  Theme.swift
//  ecommerce
//
//  Created by Rajat Tyagi on 31/05/20.
//  Copyright © 2020 Rajat Tyagi. All rights reserved.
//

import UIKit

class Theme {
    enum Colours {
        case backgroundColor
        case brandColor
    }
    
    static func color(type: Colours) -> UIColor {
        
        
        guard let hexStringBackGroundColor: String = UserDefaults.standard.object(forKey: "backgroundColour") as? String else { return UIColor(red: 100, green: 255, blue: 255, alpha: 1) }
        guard let hexStringBrandColor = UserDefaults.standard.object(forKey: "brandColour") as? String else{ return UIColor(red: 100, green: 255, blue: 255, alpha: 1) }
            
        let backgroundColour: UIColor = HexToUIColor.hexStringToUIColor(hex: hexStringBackGroundColor)
            
        let brandColour: UIColor = HexToUIColor.hexStringToUIColor(hex: hexStringBrandColor)
            
            switch type {
            case .backgroundColor :
                return backgroundColour
            case .brandColor :
                return brandColour
        }
    }
     
    
    class Fonts {
        
        static func font() -> UIFont {
            
            guard let fontFromUserDefault = UserDefaults.standard.object(forKey: "font") as? String else{ return UIFont(name: "Verdana-Italic", size: 14)! }
            return UIFont(name: fontFromUserDefault, size: 14)!
            
        }
        static func fontColor () -> UIColor {

            guard let hexStringFontColor: String = UserDefaults.standard.object(forKey: "fontColor") as? String else { return UIColor(red: 255, green: 255, blue: 255, alpha: 1) }
             let fontColor: UIColor = HexToUIColor.hexStringToUIColor(hex: hexStringFontColor)
            return fontColor
        }
        
    }
    
    static public func updateDisplay() {


        
        let proxyLabel = UILabel.appearance()
        proxyLabel.textColor = Theme.Fonts.fontColor()
        proxyLabel.font = Theme.Fonts.font()
        
//        let proxynav = UINavigationBar.appearance()
//        proxynav.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
    }
}

class HexToUIColor {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
