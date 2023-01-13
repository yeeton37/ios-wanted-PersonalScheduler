//
//  SchedularViewController.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import UIKit
import Combine

class SchedularViewController: UIViewController {
    private let tableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let viewModel: ScheduleViewModel
    private var cancelable = Set<AnyCancellable>()
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        setup()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: "ScheduleCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
    
    func bind() {
        viewModel._model
            .sink { [weak self] schedules in
                guard let self = self else { return }
                
                self.tableView.reloadData()
            }
            .store(in: &cancelable)
    }
    
    @objc func didTapAddButton() {
        let writingVC = WritingScheduleViewController()
        
        navigationController?.visibleViewController?.present(writingVC, animated: true)
    }
    
    func setup() {
        self.view.addSubview(tableView)
        view.backgroundColor = .black
        let rightButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem = rightButton
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension SchedularViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let model = viewModel.model else {
            return 3
        }
        
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else {
            return UITableViewCell()
        }
        
        guard let model = viewModel.model else { return UITableViewCell() }
        cell.transferData(schedule: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let writingVC = WritingScheduleViewController()
        
        navigationController?.visibleViewController?.present(writingVC, animated: true)
    }
}
