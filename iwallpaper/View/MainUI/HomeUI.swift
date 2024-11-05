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
    

    let sendButton = ButtonMiddleWare().createButton(title: "Continue", image: nil, size: 22, color: .black, bgColor: .systemPink, cornerRadius: 10, borderWidth: 2.5, maskToBounds: true, borderColor: .black, autoLayout: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown

        view.addSubview(sendButton)
        
        sendButton.isUserInteractionEnabled = true

        
        
       
        
        NSLayoutConstraint.activate([
        
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 65)
            
        ])
        
        setupButtonClicked()
    }
    
    func setupButtonClicked(){
        sendButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
           
           
                self.redirectToPreAuth()
            
            
        }
        
        catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func redirectToPreAuth(){
        let transiation = TransiationMiddleWare().createTransiation()
        let preAuth = PreAuthUI()
        self.view.window?.layer.add(transiation, forKey: kCATransition)
        preAuth.modalPresentationStyle = .fullScreen
        self.present(preAuth, animated: false, completion: nil)
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
