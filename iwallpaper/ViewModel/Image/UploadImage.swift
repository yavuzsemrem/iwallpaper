//
//  UploadImage.swift
//  iwallpaper
//
//  Created by Selim on 22.10.2024.
//

import Foundation
import FirebaseStorage
import UIKit


struct UploadImage {
    
    let errorMW = ErrorMiddleWare()
    
    func imageToStorage(image:UIImage,completion: @escaping (String?)->Void){
        
        let storageRef = FirebaseStorage.Storage.storage().reference().child("/profile_images\(UUID().uuidString).png")
        
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            
            storageRef.putData(imageData, metadata: nil) { metaData, error in
                
                if let error = error {
                    
                    errorMW.createError(_title: "Somethink wen't wrong", _message: "Error uploading image: \(error.localizedDescription)") { action in
                        
                    }
                    
                    completion(nil)
                    return
                    
                }
                
                
                storageRef.downloadURL { url, error in
                    if let error = error {
                        
                        print("Error getting download URL: \(error.localizedDescription)")
                        completion(nil)
                        
                    }
                    
                    else {
                        completion(url?.absoluteString)
                        
                    }
                    
                    
                }
                
            }
            
        } 
        
        else {
            print("Error: Could not convert image to JPEG")
            completion(nil)
        }
    }
}
