//
//  AddMessageToTaskDTO.swift
//  
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import Fluent
import Vapor

struct AddMessageToTaskDTO: Content {
    var taskId: String
    var text: String
    var file: File?
}
