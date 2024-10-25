//
//  CheckEmailUI.swift
//  iwallpaper
//
//  Created by Selim on 19.10.2024.
//

import UIKit
import SwiftUI
import FirebaseAuth
import Alamofire

class CheckEmailUI: UIViewController,UITextFieldDelegate{
    
    
let verificationWM = VerificationCodeMiddleWare()
    let errorMW = ErrorMiddleWare()
    let stack = UIStackView()
    
    var isUserExist = false
    
    let label1 = LabelMiddleWare().createLabel(text: "Email Adress", size: 35, weight: .bold, color: .black, alignment: .center, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
    let label2 = LabelMiddleWare().createLabel(text: "Your email will be used for log in and registration", size: 20, weight: .medium, color: .black, alignment: .left, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
    let textField = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "Enter your email :", fontSize: 22, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10)
    
    let sendButton = ButtonMiddleWare().createButton(title: "Continue", image: nil, size: 22, color: .black, bgColor: .systemPink, cornerRadius: 10, borderWidth: 2.5, maskToBounds: true, borderColor: .black, autoLayout: false)
    
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
        
        sendButtonClicked()
        
    }
    
    
    @objc func hideKeyboard()
    {
        view.endEditing(true)
    }
    
    
    func sendButtonClicked(){
        
        sendButton.addTarget(self, action: #selector(checkUser), for: .touchUpInside)
        
    }
    
    
    
    @objc func checkUser(){
        
        guard let email = textField.text, !email.isEmpty else {
            
            self.errorMW.createError(_title: "Invalid email", _message: "Please enter a valid email address.") { UIAlertAction in
                print("Email is empty")
            }
            return
        }
        
        Auth.auth().fetchSignInMethods(forEmail: email) { (signInMethods, error) in
            
            if let error = error {
               
                self.errorMW.createError(_title: "Something went wrong", _message: error.localizedDescription) { UIAlertAction in
                    print(error.localizedDescription)
                }
            } else {
                if let methods = signInMethods, !methods.isEmpty {
                    
                    self.isUserExist = true
                    
                    let verifyUserUI = CodeVerificationUI()
                    verifyUserUI.isUserExist = self.isUserExist
                    verifyUserUI.userEmail = email
                    
                    var code = self.verificationWM.createCode()
                    
                    self.verificationWM.sendEmail(email: email, code: code)
                    
                    verifyUserUI.code = code
                    
                    self.navigationController?.pushViewController(verifyUserUI, animated: true)
                    
                } else {
                    
                    self.isUserExist = false
                   
                    self.errorMW.createError(_title: "No account found", _message: "You need to create an account first.") { action in
                        
                        let signUp = SignUpUI()
                        signUp.isUserExist = self.isUserExist
                        signUp.emailTextfield.text = self.textField.text
                        
                        self.navigationController?.pushViewController(signUp, animated: true)
                    }
                }
            }
        }
    }
    
    
}



struct CheckEmailUIController_Preview: PreviewProvider {
    static var previews: some View {
        CheckEmailUIControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct CheckEmailUIControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CheckEmailUI {
        return CheckEmailUI()
    }
    
    func updateUIViewController(_ uiViewController: CheckEmailUI, context: Context) {
        
    }
}


