//
//  ColorMiddleWare.swift
//  iwallpaper
//
//  Created by Selim on 19.10.2024.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexColor = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Hex kodu "#" ile başlıyorsa, kaldır
        if hexColor.hasPrefix("#") {
            hexColor.removeFirst()
        }

        var rgb: UInt64 = 0
        Scanner(string: hexColor).scanHexInt64(&rgb)

        let red = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let green = CGFloat((rgb >> 8) & 0xFF) / 255.0
        let blue = CGFloat(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
