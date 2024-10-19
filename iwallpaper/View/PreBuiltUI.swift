import UIKit
import SwiftUI

class PreBuiltUI: UIViewController {
    
    
    let logo : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IWP"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Millions of Wallpapers. Free on IWallpaper."
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false //AutoLayout'u kapadık
        return label
    }()
    
    
    let signUpButton = ButtonMiddleWare().createButton(
        title: "Sign up free",
        image: nil,
        imageSize: CGSize(width: 30, height: 30),
        size: 22,
        color: .black,
        bgColor: .systemPink,
        cornerRadius: 30,
        borderWidth: 2.5,
        maskToBounds: true,
        borderColor: .systemPink,
        autoLayout: false) {
            print("deneme")
        }
    
    let emailButton = ButtonMiddleWare().createButton(
        title: "Continue with Email",
        image: UIImage(named: "email"),
        imageSize: CGSize(width: 30, height: 30),
        size: 22,
        color: .white,
        bgColor: .black,
        cornerRadius: 30,
        borderWidth: 2.5, 
        maskToBounds: true,
        borderColor: .darkGray,
        autoLayout: false)
    
    
    let googleButton = ButtonMiddleWare().createButton(
        title: "Continue with Google",
        image: UIImage(named: "google"),
        imageSize: CGSize(width: 30, height: 30),
        size: 22,
        color: .white,
        bgColor: .black,
        cornerRadius: 30, 
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
        cornerRadius: 30,
        borderWidth: 2.5,
        maskToBounds: true, 
        borderColor: .darkGray,
        autoLayout: false)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(frame: view.bounds)
        bg.image = UIImage(named: "bg")
        bg.contentMode = .scaleAspectFill
        
        signUpButton.isUserInteractionEnabled = true
        googleButton.isUserInteractionEnabled = true
        emailButton.isUserInteractionEnabled = true
        appleButton.isUserInteractionEnabled = true
        
        view.backgroundColor = .white
        view.addSubview(bg)
        view.addSubview(label)
        view.addSubview(signUpButton)
        view.addSubview(emailButton)
        view.addSubview(googleButton)
        view.addSubview(appleButton)
        view.addSubview(logo)
        
        
        
        label.frame = CGRect(x: 25, y: 0, width:view.bounds.width - 50, height: view.bounds.height - 10)
        
        logo.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        let stackView = UIStackView(arrangedSubviews: [signUpButton,emailButton,googleButton,appleButton])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 150),  // Logo genişliği
            logo.heightAnchor.constraint(equalToConstant: 150), // Logo yüksekliği
            
            
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: -75), // Üstten boşluk
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 250),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -40),
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor,constant: -50),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            
            
            
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
    func makeUIViewController(context: Context) -> PreBuiltUI {
        return PreBuiltUI()
    }
    
    func updateUIViewController(_ uiViewController: PreBuiltUI, context: Context) {
        // Gerekirse UI güncellemelerini burada yapabilirsin
    }
}

