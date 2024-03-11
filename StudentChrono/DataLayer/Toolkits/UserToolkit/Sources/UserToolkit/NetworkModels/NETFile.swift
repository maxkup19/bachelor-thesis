//
//  NETFile.swift
//  
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import Foundation
import SharedDomain

public struct NETFile: Codable {
    public var filename: String
    public var data: Data
}

public extension File {
    var networkModel: NETFile {
        NETFile(
            filename: filename,
            data: data
        )
    }
}
