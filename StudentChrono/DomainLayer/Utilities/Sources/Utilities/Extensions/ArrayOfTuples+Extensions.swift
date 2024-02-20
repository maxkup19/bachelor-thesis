//
//  ArrayOfTuples+Extensions.swift
//  
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

public func ==<A: Equatable, B: Equatable>(
    lhs: [(A, B)],
    rhs: [(A, B)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}

public func ==<A: Equatable, B: Equatable, C: Equatable>(
    lhs: [(A, B, C)],
    rhs: [(A, B, C)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}

public func ==<A: Equatable, B: Equatable, C: Equatable, D: Equatable>(
    lhs: [(A, B, C, D)],
    rhs: [(A, B, C, D)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}

public func ==<A: Equatable, B: Equatable, C: Equatable, D: Equatable, E: Equatable>(
    lhs: [(A, B, C, D, E)],
    rhs: [(A, B, C, D, E)]
) -> Bool {
    guard lhs.count == rhs.count else { return false }
    for (idx, lElement) in lhs.enumerated() {
        guard lElement == rhs[idx] else {
            return false
        }
    }
    return true
}
