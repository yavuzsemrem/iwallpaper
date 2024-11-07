import UIKit
import GameKit
import FirebaseFirestoreInternal
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import SwiftUI

class PreAuthUI: UIViewController {
    
    let db = Firestore.firestore()
    
    let firebaseAuth = FetchUser()
    
    let errorMW = ErrorMiddleWare()
    
    let overLay = UIView()
    
    let stackView = UIStackView()
    
    let logo : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IWP"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   
    
    
    let label = LabelMiddleWare().createLabelWidthAutoLayout(text: "Millions of Wallpapers. Free on IWallpaper.", weight: .bold, color: .white, alignment: .center, line: 0, lineBreak: .byWordWrapping, autoLayout: false,screen: UIScreen.main)
    
    
    
    
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
        autoLayout: false
    )
    
    
    
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
        autoLayout: false
    )
    
    
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
        autoLayout: false
    )
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(frame: view.bounds)
        bg.image = UIImage(named: "bg")
        bg.contentMode = .scaleAspectFill
        
        
        overLay.backgroundColor = .black
        overLay.alpha = 0.5
        overLay.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .blue
        view.addSubview(bg)
        view.addSubview(overLay)
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(signUpButton)
        view.addSubview(googleButton)
        view.addSubview(appleButton)

        
        
        view.addSubview(stackView)
        
        setupStackView()
        
        setupConstraints()
        
        setupButtonActions()
        
        setupGradientLayer() // Gradient Layer'i eklemek için fonksiyonu çağırıyoruz

        
    }
    
    
    //Setup Buttons
    func setupButtonActions(){
        
        self.signUpButton.addTarget(self, action: #selector(navigateToCheckEmail), for: .touchUpInside)
        
        self.googleButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)
 
    }
    
  
    //Google sign In Button Actions
    
    @objc func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
  
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
       
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            var email = user.profile?.email
            
            firebaseAuth.fetchUser(email: email!) { response in
                
                if response == false {
                    showSignUpUI(email: user.profile!.email, user: user)
                }
                
                else {
                    navigateToHome()
                }
            }
        }
    }
    
    
    //Navigate to Home View
    private func navigateToHome() {
        let transition = TransiationMiddleWare().createTransiation()
        let home = HomeUI()
        self.view.window?.layer.add(transition, forKey: kCATransition)
        home.modalPresentationStyle = .fullScreen
        self.present(home, animated: false, completion: nil)
    }
    
    //Navigate to Sign Up View
    private func showSignUpUI(email: String, user: GIDGoogleUser) {
        let signUp = SignUpUI()
        signUp.emailTextfield.text = email
        
        
        DispatchQueue.main.async {
            if let photoURL = user.profile?.imageURL(withDimension: 200) {
                if let data = try? Data(contentsOf: photoURL) {
                    signUp.imageView.image = UIImage(data: data)
                }
            }
        }
        
        
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    
    //Setting up StackView
    func setupStackView() {
        
        let _ : UIStackView = {
            
            stackView.axis = .vertical
            stackView.spacing = 20
            stackView.translatesAutoresizingMaskIntoConstraints = false //canceled Auto Layout
            stackView.distribution = .fillEqually
            stackView.addArrangedSubview(signUpButton)
            stackView.addArrangedSubview(googleButton)
            stackView.addArrangedSubview(appleButton)

            return stackView
        }()
        
    }
    
    
    //Setting Constrains
    func setupConstraints(){
        
        
        //Layer
        NSLayoutConstraint.activate([
            overLay.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            overLay.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            overLay.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            overLay.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
        
        
        //Logo
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),
            logo.widthAnchor.constraint(equalToConstant: 230),
            logo.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        //Label
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        
        //Buttons StackView
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 235)
        ])
        
    }
    
    
    
    
    @objc func navigateToCheckEmail(){
        let checkEmail = CheckEmailUI()
        navigationController?.pushViewController(checkEmail, animated: true)
    }
    
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = overLay.bounds
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(1.0).cgColor, // Aşağıda opak
            UIColor.black.withAlphaComponent(0.0).cgColor  // Yukarıda transparan
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0) // Aşağıda başla
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)   // Yukarıda bitir
        overLay.layer.addSublayer(gradientLayer)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // overLay'in boyutu değiştikçe gradientLayer'in de boyutunu güncelliyoruz
        overLay.layer.sublayers?.forEach { sublayer in
            if let gradientLayer = sublayer as? CAGradientLayer {
                gradientLayer.frame = overLay.bounds
            }
        }
    }

    
    
}


//Preview

struct MyViewController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PreAuthUI {
        return PreAuthUI()
    }
    
    func updateUIViewController(_ uiViewController: PreAuthUI, context: Context) {
      
    }
}

