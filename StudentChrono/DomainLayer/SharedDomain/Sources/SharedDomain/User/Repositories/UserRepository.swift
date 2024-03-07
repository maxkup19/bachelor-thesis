//
//  UserRepository.swift
//  
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import Spyable

@Spyable
public protocol UserRepository {
    func getCurrentUser() async throws -> User
    func updateUserInfo(_ payload: UpdateUserInfoData) async throws
    func verifyPassword(_ payload: UpdatePasswordData) async throws
    func updatePassword(_ payload: UpdatePasswordData) async throws
    func uploadUserImage(_ payload: File) async throws -> User
    func deleteAccount() async throws
}
