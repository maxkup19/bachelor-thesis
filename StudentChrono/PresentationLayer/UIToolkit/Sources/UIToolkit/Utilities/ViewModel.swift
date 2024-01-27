//
//  ViewModel.swift
//
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

@MainActor
public protocol ViewModel {
    // Lifecycle
    func onAppear()
    func onDisappear()
    
    // State
    associatedtype State
    var state: State { get }
    
    // Intent
    associatedtype Intent
    func onIntent(_ intent: Intent)
}
