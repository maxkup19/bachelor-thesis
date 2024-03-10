//
//  NETFile.swift
//  
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import Foundation
import SharedDomain

struct NETFile: Codable {
    var filename: String
    var data: Data
}

extension File {
    var networkModel: NETFile {
        NETFile(
            filename: filename,
            data: data
        )
    }
}
