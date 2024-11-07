//
//  ErrorMiddleWare.swift
//  iwallpaper
//
//  Created by Selim on 21.10.2024.
//

import Foundation
import UIKit

struct ErrorMiddleWare {
    
    
    func createError(_title : String, _message : String,action :((UIAlertAction) -> Void)?){
        
        let alert = UIAlertController(title: _title, message: _message, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: action)
        
        alert.addAction(action)
        
        
        if let topController = UIApplication.shared.windows.first?.rootViewController {
            var presentedVC = topController
            while let next = presentedVC.presentedViewController {
                presentedVC = next
            }
            presentedVC.present(alert, animated: true, completion: nil)
        }
    }
}

