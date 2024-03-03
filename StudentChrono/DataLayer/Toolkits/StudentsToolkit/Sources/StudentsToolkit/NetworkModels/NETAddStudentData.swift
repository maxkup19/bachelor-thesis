//
//  NETAddStudentData.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import SharedDomain
import Foundation

struct NETAddStudentData: Codable {
    let email: String
}

extension AddStudentData {
    var networkModel: NETAddStudentData {
        NETAddStudentData(email: email)
    }
}
