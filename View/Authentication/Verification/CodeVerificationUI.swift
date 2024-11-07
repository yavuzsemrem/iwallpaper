//
//  CodeVerificationUI.swift
//  iwallpaper
//
//  Created by Selim on 23.10.2024.
//

import UIKit
import SwiftUI

class CodeVerificationUI: UIViewController, UITextFieldDelegate{
    
   
    var code = ""
    var userEmail = ""
    var isUserExist = false
    let errorMW = ErrorMiddleWare()
    let stack = UIStackView()
    let stack2 = UIStackView()
    
    
    let textField1 = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "", fontSize: 30, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10,textAlignment: .center)
    
    let textField2 = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "", fontSize: 30, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10,textAlignment: .center)
    
    let textField3 = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "", fontSize: 30, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10,textAlignment: .center)
    
    let textField4 = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "", fontSize: 30, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10,textAlignment: .center)
    
    
    
    let label1 = LabelMiddleWare().createLabel(text: "Verification Code", size: 35, weight: .bold, color: .black, alignment: .center, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
    let label2 = LabelMiddleWare().createLabel(text: "Check your email for verification code", size: 20, weight: .medium, color: .black, alignment: .left, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
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
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        view.addSubview(textField4)
        view.addSubview(stack)
        view.addSubview(stack2)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(sendButton)
        
        
        view.backgroundColor = UIColor.white
        //view.backgroundColor = UIColor(hex: "#220138")
        
        //Label Stack
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.addArrangedSubview(label1)
        stack.addArrangedSubview(label2)
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        //Otp TextField Stack
        stack2.axis = .horizontal
        stack2.distribution = .fillEqually
        stack2.spacing = 35
        stack2.addArrangedSubview(textField1)
        stack2.addArrangedSubview(textField2)
        stack2.addArrangedSubview(textField3)
        stack2.addArrangedSubview(textField4)
        stack2.alignment = .leading
        stack2.translatesAutoresizingMaskIntoConstraints = false
        
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        
        setupConstraints()
        setupOtpTextFields()
        sendButtonClicked()
        
    }
    
    func setupOtpTextFields(){
        
        let textFields = [textField1,textField2,textField3,textField4]
        
        for textField in textFields{
            
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        
        if let text = textField.text, text.count == 1 {
                    if textField == textField1 {
                        textField2.becomeFirstResponder()
                    } else if textField == textField2 {
                        textField3.becomeFirstResponder()
                    } else if textField == textField3 {
                        textField4.becomeFirstResponder()
                    }
                } else if textField.text?.isEmpty == true {
                    // Eğer geri silme yapılmışsa bir önceki alana geç
                    if textField == textField2 {
                        textField1.becomeFirstResponder()
                    } else if textField == textField3 {
                        textField2.becomeFirstResponder()
                    } else if textField == textField4 {
                        textField3.becomeFirstResponder()
                    }
                }
    }
    
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            //stackView
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -85),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            //Otp Textfield Stack
            stack2.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 10),
            stack2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack2.heightAnchor.constraint(equalToConstant: 70),
            
            textField1.heightAnchor.constraint(equalToConstant: 70),
            textField2.heightAnchor.constraint(equalToConstant: 70),
            textField3.heightAnchor.constraint(equalToConstant: 70),
            textField4.heightAnchor.constraint(equalToConstant: 70),
            
            
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
    
    func checkTextFields(code : String) -> Bool{
        let verificationCode : String = "\(textField1.text ?? "")\(textField2.text ?? "")\(textField3.text ?? "")\(textField4.text ?? "")"
        
        print(verificationCode)
        
        if verificationCode == code {
            return true
        }
        else {
            return false
        }
    }
    
    
    func sendButtonClicked(){
        sendButton.addTarget(self, action: #selector(checkedUserStatus), for: .touchUpInside)
    }
    
    @objc func checkedUserStatus() {
        
        if isUserExist == true && !code.isEmpty{
            
          var result = checkTextFields(code: code)
            
            if result == false {
                errorMW.createError(_title: "Wrong Code!", _message: "Please try again.") { action in
                    print("wrong code")
                }
            }
            
            else {
                if !code.isEmpty && checkTextFields(code: code) == true {
                    
                    let checkPassword = CheckPasswordUI()
                    checkPassword.userEmail = userEmail
                    navigationController?.pushViewController(checkPassword, animated: true)
        
                }
            }
        }
        
        else {
            
            if !code.isEmpty && isUserExist == false{
                
                var result = checkTextFields(code: code)
                  
                  if result == false {
                      errorMW.createError(_title: "Wrong Code!", _message: "Please try again.") { action in
                          print("wrong code")
                      }
                  }
                  
                  else {

                      let transiation = TransiationMiddleWare().createTransiation()
                      let tabBar = TabBarControllerUI()
                      self.view.window?.layer.add(transiation, forKey: kCATransition)
                      tabBar.modalPresentationStyle = .fullScreen
                      self.present(tabBar, animated: false, completion: nil)
                      
                  }
                
            }
            
        }
        
        
        
        
    }
    
}


struct CodeVerificationUIController_Preview: PreviewProvider {
    static var previews: some View {
        CodeVerificationUIControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct CodeVerificationUIControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CodeVerificationUI {
        return CodeVerificationUI()
    }
    
    func updateUIViewController(_ uiViewController: CodeVerificationUI, context: Context) {
        
    }
}

