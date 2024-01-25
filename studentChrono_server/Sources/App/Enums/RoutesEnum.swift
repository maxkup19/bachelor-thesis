//
//  RoutesEnum.swift
//
//
//  Created by Maksym Kupchenko on 25.01.2024.
//

enum RoutesEnum {
    enum Users: String {
        case users
        enum UserParams: String {
            case id = ":id"
            case role = ":role"
        }
    }
}
