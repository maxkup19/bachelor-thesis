//
//  FeedbackViewModel.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import DependencyInjection
import Factory
import PhotosUI
import SharedDomain
import SwiftUI
import UIToolkit

final class FeedbackViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private weak var flowController: FlowController?
    
    @Injected(\.getCurrentUserUseCase) private var getCurrentUserUseCase
    
    init(flowController: FlowController?) {
        self.flowController = flowController
    }
    
    // MARK: - Lifecycle
    override func onAppear() {
        super.onAppear()
        executeTask(Task {
            await loadData()
        })
    }
    
    // MARK: - State
    @Published private(set) var state = State()
    
    struct State {
        var userEmail: String = ""
        var feedbackDescription: String = ""
        var photoPickerPresented: Bool = false
        var photoPickerItem: PhotosPickerItem?
        var loadedImage: Image?
        var isLoading: Bool = false
        var alertData: AlertData?
    }
    
    // MARK: - Intents
    enum Intent {
        case feedbackDescriptionChanged(String)
        case addScreenshotTap
        case photoPickerPresentedChanged(Bool)
        case photoPickerItemChanged(PhotosPickerItem?)
        case submitFeedback
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .feedbackDescriptionChanged(let description): feedbackDescriptionChanged(description)
            case .addScreenshotTap: addScreenshotTap()
            case .photoPickerPresentedChanged(let present): photoPickerPresentedChanged(present)
            case .photoPickerItemChanged(let item): await photoPickerItemChanged(item)
            case .submitFeedback: await submitFeedback()
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func loadData() async {
        do {
            state.userEmail = try await getCurrentUserUseCase.execute().email
        } catch { }
    }
    
    private func addScreenshotTap() {
        state.photoPickerPresented = true
    }
    
    private func photoPickerPresentedChanged(_ presented: Bool) {
        state.photoPickerPresented = presented
    }
    
    private func photoPickerItemChanged(_ item: PhotosPickerItem?) async {
        state.photoPickerItem = item
        do {
            state.loadedImage = try await item?.loadTransferable(type: Image.self)
        } catch {
            state.loadedImage = nil
        }
    }
    
    private func feedbackDescriptionChanged(_ description: String) {
        state.feedbackDescription = description
    }
    
    private func submitFeedback() async {
        
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
