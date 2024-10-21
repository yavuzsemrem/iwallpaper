import UIKit
import SwiftUI

class PreAuthUI: UIViewController {
    
    let stackView = UIStackView()
    
    let logo : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IWP"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let label = LabelMiddleWare().createLabel(text: "Millions of Wallpapers. Free on IWallpaper.", size: 35, weight: .bold, color: .white, alignment: .center, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
    let signUpButton = ButtonMiddleWare().createButton(
        title: "Continue with Email",
        image: UIImage(named: "email"),
        imageSize: CGSize(width: 30, height: 30),
        size: 22,
        color: .black,
        bgColor: .systemPink,
        cornerRadius: 10,
        borderWidth: 2.5,
        maskToBounds: true,
        borderColor: .systemPink,
        autoLayout: false) {
            print("email")
        }
    
    let googleButton = ButtonMiddleWare().createButton(
        title: "Continue with Google",
        image: UIImage(named: "google"),
        imageSize: CGSize(width: 30, height: 30),
        size: 22,
        color: .white,
        bgColor: .black,
        cornerRadius: 10,
        borderWidth: 2.5,
        maskToBounds: true,
        borderColor: .darkGray,
        autoLayout: false) {
        }
    
    let appleButton = ButtonMiddleWare().createButton(
        title: "Continue with Apple",
        image: UIImage(named: "apple"),
        imageSize: CGSize(width: 30, height: 30),
        size: 22,
        color: .white,
        bgColor: .black,
        cornerRadius: 10,
        borderWidth: 2.5,
        maskToBounds: true,
        borderColor: .darkGray,
        autoLayout: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(frame: view.bounds)
        bg.image = UIImage(named: "bg")
        bg.contentMode = .scaleAspectFill
        
        
        view.backgroundColor = .white
        view.addSubview(bg)
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(signUpButton)
        //        view.addSubview(emailButton)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        view.addSubview(stackView)
        setupStackView()
        
        setupConstraints()
        
    }
    
    
    func setupStackView() {
        
        let _ : UIStackView = {
            
            stackView.axis = .vertical
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false //canceled Auto Layout
            stackView.distribution = .fillEqually
            stackView.addArrangedSubview(signUpButton)
            //            stackView.addArrangedSubview(emailButton)
            stackView.addArrangedSubview(googleButton)
            stackView.addArrangedSubview(appleButton)
            
            return stackView
        }()
        
    }
    
    
    
    func setupConstraints(){
        
        //Logo
        NSLayoutConstraint.activate([
            
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -130),
            logo.widthAnchor.constraint(equalToConstant: 130),
            logo.heightAnchor.constraint(equalToConstant: 130),
            
        ])
        
        
        //Label
        
        NSLayoutConstraint.activate([
            
            //label 1
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
        ])
        
        //Buttons StackView
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 235)
            
            
            
        ])
        
    }
    
    
    
}



// UIViewController'ın SwiftUI Preview'da gösterilmesi
struct MyViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

// UIViewController'ı SwiftUI Preview'da göstermek için kullanılan yardımcı yapı
struct ViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PreAuthUI {
        return PreAuthUI()
    }
    
    func updateUIViewController(_ uiViewController: PreAuthUI, context: Context) {
        // Gerekirse UI güncellemelerini burada yapabilirsin
    }
}

