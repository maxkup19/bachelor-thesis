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
            screenshotName: nil
        )
        
        if let file = createFeedbackDTO.screenshot {
            let hashedFileName = try Bcrypt.hash(file.filename).replacingOccurrences(of: "/", with: "")
            let path = req.application.directory.publicDirectory + hashedFileName
            try await req.fileio.writeFile(file.data, at: path)
            feedback.screenshotName = hashedFileName
        }
        
        try await feedback.save(on: req.db)
        
        return .ok
    }
}
