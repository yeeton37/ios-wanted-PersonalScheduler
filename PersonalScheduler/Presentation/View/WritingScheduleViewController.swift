//
//  WritingScheduleViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/13.
//

import Foundation
import UIKit
import FirebaseAuth

class WritingScheduleViewController: UIViewController {
    private let verticalStackView: UIStackView = {
       let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .equalSpacing
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let titleTextField: UITextField = {
       let textField = UITextField()
        textField.text = "제목을 입력하세요."
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let bodyTextField: UITextField = {
       let textField = UITextField()
        textField.text = "내용을 입력하세요."
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let dateTextField: UITextField = {
       let textField = UITextField()
        textField.text = "시작 날짜를 입력하세요."
        textField.textColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        view.addSubview(verticalStackView)
        view.backgroundColor = .black
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: #selector(didTapSaveButton))
       
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(bodyTextField)
        verticalStackView.addArrangedSubview(dateTextField)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func didTapSaveButton() {
        guard let user = Auth.auth().currentUser,
                let userEmail = user.email,
                let title = titleTextField.text,
                let body = bodyTextField.text,
                let startDate = dateTextField.text else {
            return
        }
        
        let schedule = Schedule(email: userEmail, title: title, body: body, startDate: startDate, endDate: nil)
        
        do {
            try FirebaseManager.shared.save(schedule: schedule)
        } catch {
            print(error.localizedDescription)
        }
    }
}
