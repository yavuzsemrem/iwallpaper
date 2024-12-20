import UIKit

class ButtonMiddleWare {
    
    func createButton(
        title: String,
        image: UIImage?,
        imageSize: CGSize = CGSize(width: 30, height: 30),
        size: CGFloat,
        color: UIColor,
        bgColor: UIColor,
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        maskToBounds: Bool,
        borderColor: UIColor,
        autoLayout: Bool) -> UIButton {
            
            let button = UIButton()
            button.backgroundColor = bgColor
            button.layer.cornerRadius = cornerRadius
            button.layer.borderWidth = borderWidth
            button.layer.masksToBounds = maskToBounds
            button.layer.borderColor = borderColor.cgColor
            button.translatesAutoresizingMaskIntoConstraints = autoLayout
            
            let stackView = UIStackView()
            stackView.axis = .horizontal // Yatay hizalama
            stackView.alignment = .center
            stackView.spacing = 0 // Görseller ve metin arasındaki boşluk
            stackView.translatesAutoresizingMaskIntoConstraints = false
            
            // Resim eklenecekse
            if let image = image {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit // Görseli orantılı şekilde sığdır
                imageView.translatesAutoresizingMaskIntoConstraints = false
                
                // Görsel boyutlarını ayarlayın
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(equalToConstant: imageSize.width),
                    imageView.heightAnchor.constraint(equalToConstant: imageSize.height),
                ])
                
                stackView.addArrangedSubview(imageView)
            }
            
            // Metin oluşturma
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.systemFont(ofSize: size, weight: .bold)
            titleLabel.textColor = color
            titleLabel.textAlignment = .center // Metni ortala
            
            stackView.addArrangedSubview(titleLabel)
            button.addSubview(stackView)
            
            // Stack view'i butonun tamamına yay
            stackView.isUserInteractionEnabled = false // StackView etkileşimde bulunmasın
            
            NSLayoutConstraint.activate([
                stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                stackView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 30), // Logonun sola olan mesafesi
                stackView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -25), // Sağ taraftaki boşluk
                stackView.topAnchor.constraint(equalTo: button.topAnchor), // Yukarıdaki boşluk
                stackView.bottomAnchor.constraint(equalTo: button.bottomAnchor) // Aşağıdaki boşluk
            ])
            
            return button
        }
}
