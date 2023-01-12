//
//  ScheduleViewModel.swift
//  PersonalScheduler
//
//  Created by 이예은 on 2023/01/12.
//

import Foundation
import Combine

class ScheduleViewModel {
    var model: [Schedule]?
    var _model = PassthroughSubject<[Schedule], Never>()
    var email: String
    
    init(email: String) {
        self.email = email
    }
    
    func viewWillAppear() {
        FirebaseManager.shared.fetchAll { [weak self] schedules in
            if let self = self {
                var schedule = schedules.filter {
                    $0.email == self.email
                }
                
                self.model = schedule
                
                self._model.send(schedule)
            }
        }
    }
}
