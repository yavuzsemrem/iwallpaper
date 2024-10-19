//
//  TextfieldMiddleWare.swift
//  iwallpaper
//
//  Created by Selim on 19.10.2024.
//

import Foundation
import UIKit


struct TextfieldMiddleWare {
    
    
    func createTextfield(tintColor:UIColor,placeHolder:String,fontSize:CGFloat,placeHolderColor:String,textColor:String,bgColor:String,borderColor:String,borderStyle:UITextField.BorderStyle,borderWidth:CGFloat,cornerRadius:CGFloat) -> UITextField
    {
        let textField = UITextField()
        
        //PARAMETERS
        
        //Colors
        textField.textColor = UIColor(hex: textColor)
        textField.backgroundColor = UIColor(hex: bgColor)
        textField.layer.borderColor = UIColor(hex: borderColor)?.cgColor
        textField.tintColor = tintColor
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: placeHolderColor) as Any
        ]
        
        //Texts
        let placeholderText = placeHolder
        textField.font = UIFont.systemFont(ofSize: fontSize)
        
        //borders
        textField.borderStyle = borderStyle
        textField.layer.borderWidth = borderWidth
        textField.layer.cornerRadius = 10
        
        
        
        //NONE-PARAMETERS
        
        //Text-Alignment
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        textField.leftView = paddingView
        textField.rightView = paddingView
        textField.rightViewMode = .always
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        
        
        //User Interactions
        textField.isUserInteractionEnabled = true
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        //PlaceHolder
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        
        return textField
    }
    
    
}
