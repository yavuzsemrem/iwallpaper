//
//  CheckPasswordUI.swift
//  iwallpaper
//
//  Created by Selim on 20.10.2024.
//

import UIKit
import SwiftUI

class CheckPasswordUI: UIViewController, UITextFieldDelegate {

    private let passwordToggleButton = UIButton(type: .custom)

    let stack = UIStackView()
    
    let label1 = LabelMiddleWare().createLabel(text: "Enter Your Password", size: 35, weight: .bold, color: .black, alignment: .center, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    let label2 = LabelMiddleWare().createLabel(text: "Enter your password to continue", size: 20, weight: .medium, color: .black, alignment: .left, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    let textField = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "Enter your password :", fontSize: 22, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10)
    
    let sendButton = ButtonMiddleWare().createButton(title: "Continue", image: nil, size: 22, color: .black, bgColor: .systemPink, cornerRadius: 30, borderWidth: 2.5, maskToBounds: true, borderColor: .black, autoLayout: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keyboard function
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        // View registration
        view.addSubview(textField)
        view.addSubview(stack)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(sendButton)
        
        view.backgroundColor = UIColor.white
        
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.addArrangedSubview(label1)
        stack.addArrangedSubview(label2)
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        
        // Şifre görünürlüğünü ayarlayan fonksiyonu burada çağırıyoruz
        setupPasswordField()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // StackView
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -85),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // TextField
            textField.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 65),
            
            // SendButton
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    private func setupPasswordField() {
        // Şifrenin gizlenmesi için başlangıçta `isSecureTextEntry` true olarak ayarlıyoruz
        textField.isSecureTextEntry = true
        
        // Sağ tarafa eklemek için bir UIButton oluşturuyoruz
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .highlighted)
        
        // Toggle buttonuna basılı tutulduğunda şifreyi göster, bırakınca tekrar gizle
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibilityDown), for: .touchDown)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibilityUp), for: [.touchUpInside, .touchUpOutside])
        
        // Sağ tarafta yer alan butonu ayarlıyoruz
        passwordToggleButton.translatesAutoresizingMaskIntoConstraints = false
        textField.rightViewMode = .always
        textField.rightView = passwordToggleButton // Butonu sağ görünüm olarak ayarlayın

        // Butonun boyutunu ve konumunu ayarlayın
        passwordToggleButton.widthAnchor.constraint(equalToConstant: 65).isActive = true // Butonun genişliği
        passwordToggleButton.heightAnchor.constraint(equalToConstant: 65).isActive = true // Butonun yüksekliği
        
        // Butonun içeriğini 20 birim sola kaydırın
        passwordToggleButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -20).isActive = true // 20 birim boşluk bırakın
        passwordToggleButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true // Yükseklik merkezde
    }
    
    // Şifreyi gösterme işlemi (basılı tutarken)
    @objc private func togglePasswordVisibilityDown() {
        textField.isSecureTextEntry = false // TextField üzerinden isSecureTextEntry özelliğini ayarlıyoruz
    }
    
    // Şifreyi tekrar gizleme işlemi (butondan el kalkınca)
    @objc private func togglePasswordVisibilityUp() {
        textField.isSecureTextEntry = true // TextField üzerinden isSecureTextEntry özelliğini ayarlıyoruz
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func navigateToMain() {
        let main = PreAuthUI()
        navigationController?.pushViewController(main, animated: true)
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

