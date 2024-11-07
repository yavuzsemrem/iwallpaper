//
//  LabelMiddleWare.swift
//  iwallpaper
//
//  Created by Selim on 19.10.2024.
//

import Foundation
import UIKit


struct LabelMiddleWare {
    
    func createLabel(text:String, size:CGFloat, weight:UIFont.Weight,color:UIColor,alignment:NSTextAlignment,line:Int,lineBreak : NSLineBreakMode,autoLayout:Bool) -> UILabel{
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = line
        label.lineBreakMode = lineBreak
        label.translatesAutoresizingMaskIntoConstraints = autoLayout
        return label
    }
    
    
    func createLabelWidthAutoLayout(text:String, weight:UIFont.Weight,color:UIColor,alignment:NSTextAlignment,line:Int,lineBreak : NSLineBreakMode,autoLayout:Bool,screen: UIScreen) -> UILabel{
        
        let fontSize = determineFontSize(for: screen)
        
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = line
        label.lineBreakMode = lineBreak
        label.translatesAutoresizingMaskIntoConstraints = autoLayout
        label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.5
        print(fontSize)
        return label
    }
    
    
    private func determineFontSize(for screen: UIScreen) -> CGFloat {
        let screenNativeWidth = screen.nativeBounds.width
        let screenNativeHeight = screen.nativeBounds.height
        
        switch screenNativeWidth {
        case ...750: // Küçük ekranlar (örneğin, iPhone SE)
            return 32
        case 751...1170: // Orta ekranlar (örneğin, iPhone 13, iPhone 15)
            return 32
        case 1171...1290:
            // iPhone 15 Pro gibi cihazlar için 28 pt, Pro Max için 35 pt
            return screenNativeHeight <= 2556 ? 32 : 35
        default:
            return 35 // Varsayılan font boyutunu 35 olarak belirliyoruz
        }
    }
    
}
