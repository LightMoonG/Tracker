//
//  Colors + Extension.swift
//  Tracker
//
//  Created by Глеб Хамин on 05.08.2024.
//

import UIKit

extension UIColor {
    static var ypBlack: UIColor { UIColor(named: "Black") ?? UIColor.darkGray }
    static var ypBackground: UIColor { UIColor(named: "Background") ?? UIColor.darkGray }
    static var ypBlue: UIColor { UIColor(named: "Blue") ?? UIColor.darkGray }
    static var ypGray: UIColor { UIColor(named: "Gray") ?? UIColor.darkGray }
    static var ypLightGray: UIColor { UIColor(named: "Light Gray") ?? UIColor.darkGray }
    static var ypRed: UIColor { UIColor(named: "Red") ?? UIColor.darkGray }
    static var ypWhite: UIColor { UIColor(named: "White") ?? UIColor.darkGray }
    
    static var ypTabBarGray: UIColor { UIColor(named: "TabBarGray") ?? UIColor.darkGray }
    static var ypSearchBackground: UIColor { UIColor(named: "SearchBackground") ?? UIColor.darkGray }
    
    
}

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension UIColor {
    var hex: String? {
        guard let components = cgColor.components, components.count >= 3 else { return nil }
        
        let r = components[0]
        let g = components[1]
        let b = components[2]
        let a = components.count == 4 ? components[3] : 1.0
        
        let hexR = String(format: "%02x", Int(r * 255))
        let hexG = String(format: "%02x", Int(g * 255))
        let hexB = String(format: "%02x", Int(b * 255))
        let hexA = String(format: "%02x", Int(a * 255))
        
        if a == 1.0 {
            return "#\(hexR)\(hexG)\(hexB)"
        } else {
            return "#\(hexR)\(hexG)\(hexB)\(hexA)"
        }
    }
}

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}
