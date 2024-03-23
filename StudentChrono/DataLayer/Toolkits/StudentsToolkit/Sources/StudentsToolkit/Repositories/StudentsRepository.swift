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
        try await network.request(StudentsAPI.addStudent(data), withInterceptor: false)
    }
    
    public func removeStudent(_ payload: RemoveStudentData) async throws {
        let data = try payload.networkModel.encode()
        try await network.request(StudentsAPI.removeStudent(data), withInterceptor: false)
    }
    
    public func getMyStudents() async throws -> [User] {
        try await network
            .request(StudentsAPI.getMyStudents, withInterceptor: false)
            .map([NETUser].self)
            .map(\.domainModel)
    }
    
    public func getStudentById(_ id: String) async throws -> User {
        try await network.request(StudentsAPI.getStudentById(id), withInterceptor: false)
            .map(NETUser.self)
            .domainModel
    }
}
