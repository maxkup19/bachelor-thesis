//
//  AddStudentData.swift
//  
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

public struct AddStudentData: Codable {
    public let studentId: String
    
    public init(studentId: String) {
        self.studentId = studentId
    }
}
