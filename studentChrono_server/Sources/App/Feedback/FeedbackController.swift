//
//  FeedbackController.swift
//
//
//  Created by Maksym Kupchenko on 10.03.2024.
//

import Vapor

struct FeedbackController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let feedbackRoute = routes
            .grouped(Configuration.baseApi)
            .grouped(FeedbackRoutes.base)
        
        feedbackRoute.post(use: createFeedback)
    }
    
    private func createFeedback(req: Request) async throws -> HTTPStatus {
        let createFeedbackDTO = try req.content.decode(CreateFeedbackDTO.self)
        
        let feedback = Feedback(
            email: createFeedbackDTO.email,
            description: createFeedbackDTO.description,
            screenshotName: createFeedbackDTO.screenshot
        )
        
        try await feedback.save(on: req.db)
        
        return .ok
    }
}
