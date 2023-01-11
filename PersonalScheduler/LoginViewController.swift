//
//  ViewController.swift
//  PersonalScheduler
//
//  Created by kjs on 06/01/23.
//

import UIKit

class LoginViewController: UIViewController {
    private let topVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .center
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "book.fill")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.tintColor = .brown
        imageview.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return imageview
    }()
    
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.text = "다이어리에 오신 것을 환영합니다."
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let emailLoginButton: UIButton = {
       let button = UIButton()
        button.setTitle(" 이메일로 계속하기 ", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    
    private let googleLoginButton: UIButton = {
       let button = UIButton()
        button.setTitle("Google로 계속하기", for: .normal)
        button.setImage(UIImage(named: "logo_google.png"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let appleLoginButton: UIButton = {
       let button = UIButton()
        button.setTitle(" Apple로 계속하기 ", for: .normal)
        button.setImage(UIImage(named: "logo_apple.png"), for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setAutolayout()
        
        emailLoginButton.addTarget(self, action: #selector(didTapEmailLoginButton), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(didTapGoogleLoginButton), for: .touchUpInside)
        appleLoginButton.addTarget(self, action: #selector(didTapAppleLoginButton), for: .touchUpInside)
    }
    
    @objc func didTapEmailLoginButton() {
        let emailVC = CreateEmailViewController()
        navigationController?.pushViewController(emailVC, animated: true)
    }
    
    @objc func didTapGoogleLoginButton() {
        
    }
    
    @objc func didTapAppleLoginButton() {
        let facebookVC = FacebookLoginViewController()
        navigationController?.pushViewController(facebookVC, animated: true)
    }
    
    func setup() {
        view.backgroundColor = .black
        view.addSubview(topVerticalStackView)
        view.addSubview(bottomVerticalStackView)
        
        topVerticalStackView.addArrangedSubview(imageView)
        topVerticalStackView.addArrangedSubview(introduceLabel)
        
        bottomVerticalStackView.addArrangedSubview(emailLoginButton)
        bottomVerticalStackView.addArrangedSubview(googleLoginButton)
        bottomVerticalStackView.addArrangedSubview(appleLoginButton)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topVerticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            topVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            topVerticalStackView.heightAnchor.constraint(equalToConstant: 110),
            
            bottomVerticalStackView.topAnchor.constraint(equalTo: topVerticalStackView.bottomAnchor, constant: 60),
            bottomVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            bottomVerticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
}

