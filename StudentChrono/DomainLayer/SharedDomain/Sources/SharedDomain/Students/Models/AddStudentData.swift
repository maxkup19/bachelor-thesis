//
//  AddStudentData.swift
//  
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

public struct AddStudentData: Codable {
    public let email: String
    
    public init(email: String) {
        self.email = email
    }
}
