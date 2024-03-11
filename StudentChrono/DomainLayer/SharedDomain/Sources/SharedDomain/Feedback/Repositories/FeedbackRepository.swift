//
//  FeedbackRepository.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import Spyable

@Spyable
public protocol FeedbackRepository {
    func sendFeedback(_ payload: CreateFeedbackData) async throws
}
