//
//  FeedbackRepository.swift
//  
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import NetworkProvider
import SharedDomain

public struct FeedbackRepositoryImpl: FeedbackRepository {
    
    private let network: NetworkProvider
    
    public init(network: NetworkProvider) {
        self.network = network
    }
    
    public func sendFeedback(_ payload: CreateFeedbackData) async throws {
        let data = try payload.networkModel.encode()
        
        do {
            try await network.request(FeedbackAPI.feedback(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw FeedbackError.feedbackError(description: message?.reason)
        }
    }
}
