//
//  StudentsRepository.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import NetworkProvider
import SharedDomain
import UserToolkit

public struct StudentsRepositoryImpl: StudentsRepository {
    
    private let network: NetworkProvider
    
    public init(network: NetworkProvider) {
        self.network = network
    }
    
    public func addStudent(_ payload: AddStudentData) async throws {
        let data = try payload.networkModel.encode()
        do {
            try await network.request(StudentsAPI.addStudent(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw StudentsError.studentsError(description: message?.reason)
        }
    }
    
    public func removeStudent(_ payload: RemoveStudentData) async throws {
        let data = try payload.networkModel.encode()
        do {
            try await network.request(StudentsAPI.removeStudent(data), withInterceptor: false)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw StudentsError.studentsError(description: message?.reason)
        }
    }
    
    public func getMyStudents() async throws -> [User] {
        do {
            return try await network
                .request(StudentsAPI.getMyStudents, withInterceptor: false)
                .map([NETUser].self)
                .map(\.domainModel)
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw StudentsError.studentsError(description: message?.reason)
        }
    }
    
    public func getStudentById(_ id: String) async throws -> User {
        do {
            return try await network.request(StudentsAPI.getStudentById(id), withInterceptor: false)
                .map(NETUser.self)
                .domainModel
        } catch let NetworkProviderError.requestFailed(_, message) {
            throw StudentsError.studentsError(description: message?.reason)
        }
    }
}
