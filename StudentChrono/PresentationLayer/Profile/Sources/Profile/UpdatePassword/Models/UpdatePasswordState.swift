//
//  UpdatePasswordState.swift
//
//
//  Created by Maksym Kupchenko on 05.03.2024.
//

import SwiftUI

enum UpdatePasswordState: Equatable {
    case verify
    case update
    
    var progressViewTitle: LocalizedStringKey {
        switch self {
        case .verify: "Verifying..."
        case .update: "Updating..."
        }
    }
    
    var toolbarButtonTitle: String {
        switch self {
        case .verify: "Next"
        case .update: "**Change**"
        }
    }
}
