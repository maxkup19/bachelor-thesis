//
//  Environment+Extensions.swift
//
//
//  Created by Maksym Kupchenko on 27.01.2024.
//

import SwiftUI

public extension EnvironmentValues {
    var isLoading: Bool {
        get { self[LoadingKey.self] }
        set { self[LoadingKey.self] = newValue }
    }
}
