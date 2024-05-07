//
//  CreateFeedbackDTO.swift
//
//
//  Created by Maksym Kupchenko on 10.03.2024.
//

import Vapor

struct CreateFeedbackDTO: Content {
    var email: String
    var description: String
    var screenshot: String?
}
