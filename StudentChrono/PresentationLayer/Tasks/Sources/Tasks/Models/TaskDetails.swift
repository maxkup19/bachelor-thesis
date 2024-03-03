//
//  TaskDetails.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation
import SharedDomain

struct TaskDetails: Equatable {
    var dueTo: Date?
    var tags: [String] = []
    var priority: Priority = .none
}
