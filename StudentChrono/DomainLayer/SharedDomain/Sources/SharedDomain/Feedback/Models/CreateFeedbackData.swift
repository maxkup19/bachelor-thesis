//
//  CreateFeedbackData.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

public struct CreateFeedbackData: Codable {
    public let email: String
    public let description: String
    public let screenshot: File?
    
    public init(
        email: String,
        description: String,
        screenshot: File? = nil
    ) {
        self.email = email
        self.description = description
        self.screenshot = screenshot
    }
}
