//
//  Configuration.swift
//
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Vapor

enum Configuration {
    
    static let baseApi: PathComponent = "api"
    static let tokenExpiryDate: DateComponents = DateComponents(year: 1)
    
}
