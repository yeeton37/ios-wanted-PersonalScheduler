//
//  ScheduleCell.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import Foundation
import UIKit

class ScheduleCell: UITableViewCell {
    private let verticalStackView: UIStackView = {
       let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .equalSpacing
        stackview.spacing = 4
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "제목입니다."
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startDateLabel: UILabel = {
       let label = UILabel()
        label.text = "실행일시"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel: UILabel = {
       let label = UILabel()
        label.text = "내용입니다."
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .black
        setup()
        setupAutolayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        contentView.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(startDateLabel)
        verticalStackView.addArrangedSubview(bodyLabel)
    }
    
    func setupAutolayout() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func transferData(schedule: Schedule) {
        titleLabel.text = schedule.title
        bodyLabel.text = schedule.body
        startDateLabel.text = schedule.startDate
    }
}
