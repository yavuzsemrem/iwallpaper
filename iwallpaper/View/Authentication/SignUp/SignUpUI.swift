//
//  SignUpUI.swift
//  iwallpaper
//
//  Created by Selim on 20.10.2024.
//

import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class SignUpUI: UIViewController, UITextFieldDelegate & UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    

    let errorMW = ErrorMiddleWare()
    
    let datePicker = UIDatePicker()
    
    let stack = UIStackView()
    
    let imageView = UIImageView(image: UIImage(named: "IWP"))

    
    let label = LabelMiddleWare().createLabel(text: "Public profile image", size: 22, weight: .bold, color: .black, alignment: .center, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    let birthdayTextfield = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "Enter your birthday :", fontSize: 22, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10)
    
    let emailTextfield = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "Enter your email :", fontSize: 22, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10)
    
    let passwordTextfield = TextfieldMiddleWare().createTextfield(tintColor:.systemPink,placeHolder: "Enter your password :", fontSize: 22, placeHolderColor: "D4ADFC", textColor: "D4ADFC", bgColor: "0C134F", borderColor: "D4ADFC", borderStyle: .none, borderWidth: 2, cornerRadius: 10)
    
    let sendButton = ButtonMiddleWare().createButton(title: "Continue", image: nil, size: 22, color: .black, bgColor: .systemPink, cornerRadius: 10, borderWidth: 2.5, maskToBounds: true, borderColor: .black, autoLayout: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imageView.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageSelection))
        
        imageView.addGestureRecognizer(gestureRecognizer)
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true
        }
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(birthdayTextfield)
        view.addSubview(emailTextfield)
        view.addSubview(passwordTextfield)
        view.addSubview(sendButton)
        view.addSubview(stack)
        view.addSubview(imageView)
        view.addSubview(label)
        
        
        stack.addArrangedSubview(birthdayTextfield)
        stack.addArrangedSubview(emailTextfield)
        stack.addArrangedSubview(passwordTextfield)
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 35
        stack.distribution = .fillEqually
        
        
    
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.yellow.cgColor
        imageView.layer.cornerRadius = 60
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        birthdayTextfield.delegate = self
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
        
        setupConstraints()
        
        
        addCalendarIconToTextField()
                
                // DatePicker ayarları
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline // İsteğe bağlı
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
    }
    
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
        
        //Stack view
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stack.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stack.heightAnchor.constraint(equalToConstant: 275),
            
            
            //Button
            
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -75),
            sendButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 65),
            
            //ImageView
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            //Label
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15)
            
        
            
        ])
        
        sendButtonClicked()
    }
    
    
    func sendButtonClicked(){
        
        sendButton.addTarget(self, action: #selector(navigateToMain), for: .touchUpInside)
        
    }
    
    
    @objc func navigateToMain()
    {
        Auth.auth().createUser(withEmail: emailTextfield.text ?? "", password: passwordTextfield.text ?? "") { authResult, error in
            
            if let error = error {
                
                self.errorMW.createError(_title: "Somethink wen't wrong", _message: String(error.localizedDescription)) { action in
                }
            }
            
            let birthday = self.birthdayTextfield.text
            
            let password = self.passwordTextfield.text
            
            let image = self.imageView.image
            
            guard let user = authResult?.user else {return}
            
            self.saveUserToFirestore(id: user.uid, email: user.email!, password: password!, birthday: birthday!,image: image!)
            
        }
    }
    
    
    func saveUserToFirestore(id:String, email:String, password: String, birthday: String,image:UIImage){
        
        let db = Firestore.firestore()
        
        
        let imageUrl: () = UploadImage().imageToStorage(image: image) { imageUrl in
            
            if let imageUrl = imageUrl {
                
                db.collection("User").document(id).setData([
                    
                    "id" : id,
                    "email" : email,
                    "password" : password,
                    "birthday" : birthday,
                    "imageUrl" : imageUrl
                    
                ]){error in
                    
                    if let error = error {
                        
                        self.errorMW.createError(_title: "Somethink wen't wrong", _message: error.localizedDescription) { action in
                            
                        }
                        
                    }
                    
                    
                    else {
                        let preAuth = PreAuthUI()
                        
                        print("User saved to firestore successfuly")
                        self.navigationController?.pushViewController(preAuth, animated: true)
                        
                    }
                    
                    
                }
                
            }
            
        }
        
    }
    
    @objc func hideKeyboard()
    {
        view.endEditing(true)
    }
    
    
    
    @objc func ImageSelection(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: false)
    }
    
    
    
    // TextField'a sağa calendar iconu eklemek
        func addCalendarIconToTextField() {
            let calendarButton = UIButton(type: .custom)
               
               // Sistem simgesinin boyutunu artırıyoruz
               let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold)
               let largeCalendarImage = UIImage(systemName: "calendar", withConfiguration: largeConfig)
               calendarButton.setImage(largeCalendarImage, for: .normal)
               
               calendarButton.tintColor = .systemPink
               calendarButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50) // Buton boyutunu artırıyoruz
               calendarButton.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
               
               // Butonu padding ile sola kaydırıyoruz
               let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 50)) // Genişlik paddingi ayarlıyor
               paddingView.addSubview(calendarButton)
               
               calendarButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50) // x: 5 ile biraz içeride duruyor
               
               // Sağ view olarak paddingView'i ekliyoruz
               birthdayTextfield.rightView = paddingView
               birthdayTextfield.rightViewMode = .always
        }

        // DatePicker'ı göstermek için fonksiyon
    // DatePicker'ı göstermek için fonksiyon
        @objc func showDatePicker() {
            // DatePicker'ı textField'ın inputView'ine ekleyelim
            birthdayTextfield.inputView = datePicker
            
            birthdayTextfield.becomeFirstResponder() // DatePicker'ı açmak için
        }

        // Tarih değiştiğinde çağrılacak fonksiyon
        @objc func dateChanged() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            
            // Seçilen tarihi formatlayıp textField'a yazıyoruz
            birthdayTextfield.text = dateFormatter.string(from: datePicker.date)
        }
    
    
    
}
 

    
struct SignUpUIController_Preview: PreviewProvider {
    static var previews: some View {
        SignUpUIControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct SignUpUIControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SignUpUI {
        return SignUpUI()
    }
    
    func updateUIViewController(_ uiViewController: SignUpUI, context: Context) {
        
    }
}


