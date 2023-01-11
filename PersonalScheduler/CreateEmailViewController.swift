//
//  EmailViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/09.
//

import UIKit
import FirebaseAuth

class CreateEmailViewController: UIViewController {
    private let topVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.text = "이메일을 입력해주세요."
        textfield.backgroundColor = .white
        return textfield
    }()
    
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.text = "비밀번호를 입력해주세요."
        textfield.backgroundColor = .white
        return textfield
    }()
    
    private let saveAccountButton: UIButton = {
       let button = UIButton()
        button.setTitle("생성하기", for: .normal)
        button.tintColor = .white
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
        
        saveAccountButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    @objc func didTapSaveButton() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default:
                    print(error.localizedDescription)
                }
            } else {
                self.showMainViewController()
            }
        }
    }
    
    func showMainViewController() {
        let mainVC = MainViewController()
        self.show(mainVC, sender: nil)
    }
    
    func setup() {
        view.addSubview(topVerticalStackView)
        topVerticalStackView.addArrangedSubview(emailTextField)
        topVerticalStackView.addArrangedSubview(passwordTextField)
        topVerticalStackView.addArrangedSubview(saveAccountButton)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            topVerticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            topVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            topVerticalStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.showMainViewController()
            }
        }
    }
}
