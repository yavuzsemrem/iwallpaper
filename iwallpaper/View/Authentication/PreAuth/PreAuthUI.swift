import UIKit
import GameKit
import FirebaseFirestoreInternal
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import SwiftUI

class PreAuthUI: UIViewController {
    
    let db = Firestore.firestore()
    
    var provider = OAuthProvider(providerID: "github.com")
    
    let firebaseAuth = FetchUser()
    
    let errorMW = ErrorMiddleWare()
    
    let stackView = UIStackView()
    
    let logo : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "IWP"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let label = LabelMiddleWare().createLabel(text: "Millions of Wallpapers. Free on IWallpaper.", size: 35, weight: .bold, color: .white, alignment: .left, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    let label2 = LabelMiddleWare().createLabel(text: "Make sure you get all the latest and greatest features first. We'll also keep all your downloads and credits in one place.", size: 18, weight: .regular, color: .white, alignment: .left, line: 0, lineBreak: .byWordWrapping, autoLayout: false)
    
    
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
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bg = UIImageView(frame: view.bounds)
        bg.image = UIImage(named: "bg")
        bg.contentMode = .scaleAspectFill
        
        
        view.backgroundColor = .white
        view.addSubview(bg)
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(label2)
        view.addSubview(signUpButton)
        view.addSubview(googleButton)

        view.addSubview(stackView)
        
        setupStackView()
        
        setupConstraints()
        
        setupButtonActions()
        
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

            return stackView
        }()
        
    }
    
    
    //Setting Constrains
    func setupConstraints(){
        
        //Logo
        NSLayoutConstraint.activate([
            
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),
            logo.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -40),
            logo.widthAnchor.constraint(equalToConstant: 130),
            logo.heightAnchor.constraint(equalToConstant: 130),
            
        ])
        
        
        //Label
        
        NSLayoutConstraint.activate([
            
            //label 1
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
        ])
        
        //Label2
        
        NSLayoutConstraint.activate([
            
            //label 2
            label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: -20),
            label2.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -40),
            label2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
        ])
        
        //Buttons StackView
        
        NSLayoutConstraint.activate([
            
//            stackView.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: 40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 150)
            
            
            
        ])
        
    }
    
    
    
    
    @objc func navigateToCheckEmail(){
        let checkEmail = CheckEmailUI()
        navigationController?.pushViewController(checkEmail, animated: true)
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

