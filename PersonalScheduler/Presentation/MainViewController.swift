//
//  MainViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/09.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    private let topVerticalStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .equalSpacing
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let greetingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("로그아웃", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setAutolayout()
        
        let email  = Auth.auth().currentUser?.email ?? "고객"
        greetingLabel.text = "환영합니다 \(email)님!"
        
        logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
    
    func setup() {
        view.addSubview(topVerticalStackView)
        
        topVerticalStackView.addArrangedSubview(greetingLabel)
        topVerticalStackView.addArrangedSubview(logoutButton)
    }
    
    func setAutolayout() {
        NSLayoutConstraint.activate([
            topVerticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topVerticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func didTapLogoutButton() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popViewController(animated: true)
        } catch let signoutError as NSError {
            print(signoutError.localizedDescription)
        }
    }
}
