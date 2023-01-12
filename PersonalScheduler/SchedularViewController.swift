//
//  SchedularViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import UIKit

class SchedularViewController: UIViewController {
    private let titleTextField: UITextField = {
        let titleTextField = UITextField()
        titleTextField.text = "제목을 입력하세요."
        titleTextField.textColor = .white
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        return titleTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(titleTextField)
        titleTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
}
