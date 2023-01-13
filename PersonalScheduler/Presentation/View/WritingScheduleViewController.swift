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
        stackview.distribution = .fillProportionally
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let titleTextField: UITextField = {
       let textField = UITextField()
        textField.text = "  제목을 입력하세요."
        textField.font = UIFont(name: "NotoSansKannada-Light", size: 15)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.Red_60.cgColor
        textField.layer.cornerRadius = 7
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = " 내용을 입력하세요."
        textView.font = UIFont(name: "NotoSansKannada-Light", size: 15)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.Red_60.cgColor
        textView.layer.cornerRadius = 8
        textView.textColor = .black
        textView.backgroundColor = .Beige
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let datePicker: UIDatePicker = {
       let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        view.addSubview(verticalStackView)
        view.backgroundColor = .Beige
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: nil, action: #selector(didTapSaveButton))
       
        verticalStackView.addArrangedSubview(titleTextField)
        verticalStackView.addArrangedSubview(bodyTextView)
        verticalStackView.addArrangedSubview(datePicker)
        
        NSLayoutConstraint.activate([
            bodyTextView.heightAnchor.constraint(equalToConstant: 150),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200)
        ])
    }
    
    @objc func didTapSaveButton() {
        guard let user = Auth.auth().currentUser,
                let userEmail = user.email,
                let title = titleTextField.text,
                let body = bodyTextView.text else {
            return
        }
        
        let schedule = Schedule(email: userEmail, id: UUID().uuidString, title: title, body: body, startDate: datePicker.date.toString(), endDate: nil)
        
        do {
            try FirebaseManager.shared.save(schedule: schedule)
        } catch {
            print(error.localizedDescription)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct Content_Previews: PreviewProvider {
    static var previews: some View {
        return WritingScheduleViewController().showPrieview()
    }
}
#endif

import UIKit
import SwiftUI

extension UIViewController {
    public struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        public func makeUIViewController(context: Context) -> some UIViewController { viewController }
        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }
    
    @ViewBuilder
    public func showPrieview(deviceName: String? = nil) -> some View {
        if let deviceName {
            let device = PreviewDevice(rawValue: deviceName)
            Preview(viewController: self).previewDevice(device)
        } else {
            Preview(viewController: self)
        }
    }
}

extension UIView {
    public struct Preview: UIViewRepresentable {
        let view: UIView
        public func makeUIView(context: Context) -> some UIView { view }
        public func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
    
    @ViewBuilder
    public func showPrieview(deviceName: String? = nil) -> some View {
        if let deviceName {
            let device = PreviewDevice(rawValue: deviceName)
            Preview(view: self).previewDevice(device)
        } else {
            Preview(view: self)
        }
    }
}
