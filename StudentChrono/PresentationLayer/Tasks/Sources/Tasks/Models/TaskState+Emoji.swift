//
//  TaskState+Emoji.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SharedDomain
import SwiftUI

extension TaskState {
    var emoji: String {
        switch self {
        case .draft: "📋"
        case .todo: "⚙️"
        case .inProgress: "🏗️"
        case .review: "👀"
        case .done: "✅"
        }
    }
    
    var imageStatus: some View {
        switch self {
        case .draft: Image(systemName: "smallcircle.filled.circle").foregroundStyle(Color.gray)
        case .todo, .inProgress, .review: Image(systemName: "smallcircle.filled.circle").foregroundStyle(Color.green)
        case  .done: Image(systemName: "checkmark.circle").foregroundStyle(Color.indigo)
        }
    }
    
    var title: String {
        switch self {
        case .inProgress: "In Progress"
        default: rawValue.capitalized
        }
    }
}
