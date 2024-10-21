//
//  CheckPasswordUI.swift
//  iwallpaper
//
//  Created by Selim on 20.10.2024.
//

import UIKit
import SwiftUI

class CheckPasswordUI: UIViewController, UITextFieldDelegate{

    let stack = UIStackView()
    
    let label1 = LabelMiddleWare().createLabel(text: "Enter Your Password", size: 35, weight: .bold, color: .black, alignment: .center, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
    let label2 = LabelMiddleWare().createLabel(text: "Enter your password to continue", size: 20, weight: .medium, color: .black, alignment: .left, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
    let textField = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "Enter your password :", fontSize: 22, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10)
    
    let sendButton = ButtonMiddleWare().createButton(title: "Continue", image: nil, size: 22, color: .black, bgColor: .systemPink, cornerRadius: 30, borderWidth: 2.5, maskToBounds: true, borderColor: .black, autoLayout: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Keyboard func
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true
        }
        
        
        //View registration
        view.addSubview(textField)
        view.addSubview(stack)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(sendButton)
        
        
        view.backgroundColor = UIColor.white
        //view.backgroundColor = UIColor(hex: "#220138")

        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.addArrangedSubview(label1)
        stack.addArrangedSubview(label2)
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        
        setupConstraints()
        
    }
    
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            //stackView
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -85),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            //Textfield
            textField.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 65),
            
            
            
            //SendButton
            
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 65)
            
            
        ])
        
    }
    
    
    @objc func hideKeyboard()
    {
        view.endEditing(true)
    }


}


struct CheckPasswordUIController_Preview: PreviewProvider {
    static var previews: some View {
        CheckPasswordUIControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct CheckPasswordUIControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CheckPasswordUI {
        return CheckPasswordUI()
    }
    
    func updateUIViewController(_ uiViewController: CheckPasswordUI, context: Context) {
        
    }
}
