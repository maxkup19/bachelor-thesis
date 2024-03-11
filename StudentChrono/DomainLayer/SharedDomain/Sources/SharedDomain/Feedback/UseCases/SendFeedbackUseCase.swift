//
//  SendFeedbackUseCase.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import Spyable

@Spyable
public protocol SendFeedbackUseCase {
    func execute(_ payload: CreateFeedbackData) async throws
}

public struct SendFeedbackUseCaseImpl: SendFeedbackUseCase {
    
    private let feedbackRepository: FeedbackRepository
    
    public init(feedbackRepository: FeedbackRepository) {
        self.feedbackRepository = feedbackRepository
    }
    
    public func execute(_ payload: CreateFeedbackData) async throws {
        try await feedbackRepository.sendFeedback(payload)
    }
}
