//
//  FeedbackRepository.swift
//  
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import FirebaseStorage
import NetworkProvider
import SharedDomain

public struct FeedbackRepositoryImpl: FeedbackRepository {
    
    private let network: NetworkProvider
    private let storage: Storage
    
    public init(network: NetworkProvider) {
        self.network = network
        self.storage = Storage.storage()
    }
    
    public func sendFeedback(_ payload: CreateFeedbackData) async throws {
        do {
            
            var fileURL: String?
            
            if let file = payload.screenshot {
                let reference = storage.reference().child(file.filename)
                fileURL = try await reference.putDataAsync(file.data).bucket
            }
            
            let data = try payload.networkModel(screenshot: fileURL).encode()
            try await network.request(FeedbackAPI.feedback(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw FeedbackError.feedbackError(description: message?.reason)
        }
    }
}
