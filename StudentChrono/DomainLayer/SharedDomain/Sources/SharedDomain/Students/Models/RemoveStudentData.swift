//
//  RemoveStudentData.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

public struct RemoveStudentData: Codable {
    public let studentId: String
    
    public init(studentId: String) {
        self.studentId = studentId
    }
}
