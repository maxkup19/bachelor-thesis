//
//  NETRemoveStudentData.swift
//  
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import SharedDomain

struct NETRemoveStudentData: Codable {
    let studentId: String
}

extension RemoveStudentData {
    var networkModel: NETRemoveStudentData {
        NETRemoveStudentData(studentId: studentId)
    }
}
