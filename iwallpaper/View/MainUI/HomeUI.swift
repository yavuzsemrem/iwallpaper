//
//  HomeViewController.swift
//  iwallpaper
//
//  Created by Selim on 22.10.2024.
//
import SwiftUI
import UIKit
import FirebaseAuth

class HomeUI: UIViewController{
    
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(Auth.auth().currentUser?.email)"
        
        NSLayoutConstraint.activate([
        
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
      
        
    }

}


struct HomeUIController_Preview: PreviewProvider {
    static var previews: some View {
        HomeUIControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct HomeUIControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> HomeUI {
        return HomeUI()
    }
    
    func updateUIViewController(_ uiViewController: HomeUI, context: Context) {
        
    }
}
