//
//  NETCreateFeedbackData.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import Foundation
import SharedDomain
import UserToolkit

struct NETCreateFeedbackData: Codable {
    var email: String
    var description: String
    var screenshot: NETFile?
}

extension CreateFeedbackData {
    var networkModel: NETCreateFeedbackData {
        NETCreateFeedbackData(
            email: email,
            description: description,
            screenshot: screenshot?.networkModel)
    }
}
