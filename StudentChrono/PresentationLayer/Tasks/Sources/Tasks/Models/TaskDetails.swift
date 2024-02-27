//
//  TaskDetails.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import Foundation

struct TaskDetails: Equatable {
    var date: Date?
    var tags: [String]?
    var assigneeId: UUID?
//    let priority:
    var urlString: String?
}
