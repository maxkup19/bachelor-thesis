//
//  Bundel+Extensions.swift
//
//
//  Created by Maksym Kupchenko on 05.02.2024.
//

import Foundation

public extension Bundle {
    static var app: Bundle {
        var components = main.bundleURL.path.split(separator: "/")
        var bundle: Bundle?

        if let index = components.lastIndex(where: { $0.hasSuffix(".app") }) {
            components.removeLast((components.count - 1) - index)
            bundle = Bundle(path: components.joined(separator: "/"))
        }

        return bundle ?? main
    }
}
