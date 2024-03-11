//
//  FeedbackStatus.swift
//
//
//  Created by Maksym Kupchenko on 10.03.2024.
//

import Vapor

enum FeedbackStatus: String, Content, Equatable, CaseIterable {
    case created
    case solving
    case resolved
}
