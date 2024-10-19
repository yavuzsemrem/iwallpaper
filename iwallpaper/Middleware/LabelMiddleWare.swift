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
    
}
