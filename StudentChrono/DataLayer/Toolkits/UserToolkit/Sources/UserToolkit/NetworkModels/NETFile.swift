//
//  NETFile.swift
//  
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import Foundation
import SharedDomain

struct NETFile: Codable {
    var name: String
    var data: Data
}

extension File {
    var networkModel: NETFile {
        NETFile(
            name: name,
            data: data
        )
    }
}
