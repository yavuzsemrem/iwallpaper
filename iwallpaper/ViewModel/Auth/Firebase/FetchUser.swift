//
//  FetchUser.swift
//  iwallpaper
//
//  Created by Selim on 24.10.2024.
//

import Foundation
import FirebaseAuth

struct FetchUser {
    
    let errorMW = ErrorMiddleWare()
    
    func fetchUser(email: String, complation: @escaping (Bool) -> Void) {
        
        Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
            
            if let error = error {
                
                errorMW.createError(_title: "Somethink wen't wrong", _message: "\(error.localizedDescription)") { action in
                    print(error.localizedDescription)
                }
                
            }
            
            
            if let methods = signInMethods, !methods.isEmpty {
                
                complation(true)
                
            }
            else {
                complation(false)
            }
            
        }
        
        
    }
    
}
