//
//  TabBarControllerUI.swift
//  iwallpaper
//
//  Created by Selim on 29.10.2024.
//

import UIKit

class TabBarControllerUI: UITabBarController {
   
    private let tabBarView = UIView()
       private let tabBarBackgroundView = UIView()
       private let buttonStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarView()
              setupTabBarBackgroundView()
        setupButtonStackView()
              generateControllers()

    }
    
    private func setupTabBarView() {
            view.addSubview(tabBarView)
        tabBarView.backgroundColor = .black
            tabBarView.translatesAutoresizingMaskIntoConstraints = false
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
     constant: -30).isActive = true
            tabBarView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -150).isActive = true
            tabBarView.heightAnchor.constraint(equalToConstant: 65).isActive = true
            tabBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            tabBarView.layer.cornerRadius = 30
        }

        private func setupTabBarBackgroundView() {
            tabBarView.addSubview(tabBarBackgroundView)
            tabBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            tabBarBackgroundView.topAnchor.constraint(equalTo: tabBarView.topAnchor, constant: 5).isActive = true
            tabBarBackgroundView.widthAnchor.constraint(equalTo:
     tabBarView.widthAnchor, multiplier: 1/4, constant: 20 ).isActive = true
            
            tabBarBackgroundView.leadingAnchor.constraint(equalTo: tabBarView.leadingAnchor, constant: -5).isActive = true
            
            
            tabBarBackgroundView.heightAnchor.constraint(equalTo: tabBarView.heightAnchor, constant: -10).isActive = true
            tabBarBackgroundView.layer.cornerRadius = 25
            tabBarBackgroundView.backgroundColor = .systemPink
        }

        private func setupButtonStackView() {
            buttonStackView.axis = .horizontal
            buttonStackView.distribution = .fillEqually
            buttonStackView.spacing = 10

            let homeButton = TabBarButton(image: UIImage(systemName: "house.fill")!)
            homeButton.tag = 0
            let searchButton = TabBarButton(image: UIImage(systemName: "magnifyingglass")!)
            searchButton.tag = 1
            let settingsButton = TabBarButton(image: UIImage(systemName: "gearshape.fill")!)
            settingsButton.tag = 2
            
            buttonStackView.addArrangedSubview(homeButton)
            buttonStackView.addArrangedSubview(searchButton)
            buttonStackView.addArrangedSubview(settingsButton)

            tabBarView.addSubview(buttonStackView)
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            buttonStackView.leadingAnchor.constraint(equalTo:
     tabBarView.leadingAnchor, constant: 10).isActive = true
            buttonStackView.trailingAnchor.constraint(equalTo: tabBarView.trailingAnchor, constant: -10).isActive = true
            buttonStackView.centerYAnchor.constraint(equalTo: tabBarView.centerYAnchor).isActive = true

            // Initial button selection
            let firstButton = buttonStackView.arrangedSubviews.first as! TabBarButton
            firstButton.tintColor = .black
            updateTabBarBackgroundViewPosition(for: firstButton)
         

            // Add target-action for button taps
            homeButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            searchButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            settingsButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
        }

        private func generateControllers() {
            let homeVC = HomeUI()
            let profileVC = SearchUI()
            let settingsVC = SettingsUI()

            viewControllers = [homeVC, profileVC, settingsVC]
        }

    private func updateTabBarBackgroundViewPosition(for button: TabBarButton) {
        UIView.animate(withDuration: 0.3) {
            // Adjust position with transform instead of activating a constraint
            self.tabBarBackgroundView.transform = CGAffineTransform(translationX: button.center.x - self.tabBarBackgroundView.center.x + 10, y: 0)
            self.tabBarView.layoutIfNeeded()
        }
    }

    @objc private func buttonTapped(sender: TabBarButton) {
        selectedIndex = sender.tag

        for button in buttonStackView.arrangedSubviews {
            (button as? TabBarButton)?.tintColor = .systemPink
        }
        sender.tintColor = .black

        updateTabBarBackgroundViewPosition(for: sender)
    }

}

class TabBarButton: UIButton {
    init(image: UIImage) {
        super.init(frame: .zero)
        setImage(image, for: .normal)
        tintColor = .systemPink
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
