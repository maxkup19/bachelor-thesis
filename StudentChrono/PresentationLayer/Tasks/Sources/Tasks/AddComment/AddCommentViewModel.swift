//
//  AddCommentViewModel.swift
//
//
//  Created by Maksym Kupchenko on 26.03.2024.
//

import DependencyInjection
import Factory
import PDFKit
import PhotosUI
import SharedDomain
import SharedDomainMocks
import SwiftUI
import UIToolkit

final class AddCommentViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    typealias Task = _Concurrency.Task
    
    // MARK: - Dependencies
    private let taskId: String
    private weak var flowController: FlowController?
    
    @Injected(\.addMessageToTaskUseCase) private var addMessageToTaskUseCase
    
    init(
        taskId: String,
        flowController: FlowController?
    ) {
        self.taskId = taskId
        self.flowController = flowController
        super.init()
    }
    
    // MARK: - Lifecycle
    
    // MARK: - State
    @Published private(set) var state = State()
    
    struct State {
        var pickerState: Int = 0
        var photoPickerPresented: Bool = false
        var photoPickerItem: PhotosPickerItem?
        var loadedImage: Image?
        var fileImporterPresented: Bool = false
        var fileURL: URL?
        var commentText: String = ""
        var isLoading: Bool = false
        var alertData: AlertData?
        
        enum PickerState: Int, Identifiable, CaseIterable {
            var id: Int { rawValue }
            
            case file
            case image
            
            var title: String {
                switch self {
                case .file: "File"
                case .image: "Image"
                }
            }
        }
    }
    
    // MARK: - Intents
    enum Intent {
        case addAttachmentTap
        case removeAttachmentTap
        case submit
        case commentTextChanged(String)
        case pickerStateChanged(Int)
        case photoPickerPresentedChanged(Bool)
        case photoPickerItemChanged(PhotosPickerItem?)
        case fileImporterPresentedChanged(Bool)
        case fileURLChanged(URL?)
        case dismissAlert
    }
    
    func onIntent(_ intent: Intent) {
        executeTask(Task {
            switch intent {
            case .addAttachmentTap: addAttachmentTap()
            case .removeAttachmentTap: await removeAttachmentTap()
            case .submit: await submitComment()
            case .commentTextChanged(let text): commentTextChanged(text)
            case .pickerStateChanged(let state): await pickerStateChanged(state)
            case .photoPickerPresentedChanged(let presented): photoPickerPresentedChanged(presented)
            case .photoPickerItemChanged(let item): await photoPickerItemChanged(item)
            case .fileImporterPresentedChanged(let changed): fileImporterPresentedChanged(changed)
            case .fileURLChanged(let url): fileURLChanged(url)
            case .dismissAlert: dismissAlert()
            }
        })
    }
    
    // MARK: - Private
    
    private func submitComment() async {
        state.isLoading = true
        defer { state.isLoading = false }
        
        do {
            var filename: String = taskId + state.commentText
            var fileData: Data?
            
            if let photo = state.photoPickerItem {
                fileData = try await photo.loadTransferable(type: Data.self)
                filename.append(".png")
            } else if let fileURL = state.fileURL {
                guard fileURL.startAccessingSecurityScopedResource() else {
                    state.alertData = .init(title: "Choose another file.")
                    return
                }
                fileData = PDFDocument(url: fileURL)?.dataRepresentation()
                fileURL.stopAccessingSecurityScopedResource()
                filename.append(".pdf")
            }

            let data = AddMessageToTaskData(
                taskId: taskId,
                text: state.commentText,
                file: File(
                    filename: filename,
                    data: fileData
                )
            )
            let _ = try await addMessageToTaskUseCase.execute(data)
            flowController?.pop()
        } catch {
            state.alertData = .init(title: error.localizedDescription)
        }
    }
    
    private func addAttachmentTap() {
        switch state.pickerState {
        case State.PickerState.file.rawValue: state.fileImporterPresented = true
        case State.PickerState.image.rawValue: state.photoPickerPresented = true
        default: break
        }
    }
    
    private func removeAttachmentTap() async {
        state.fileURL = nil
        await photoPickerItemChanged(nil)
    }
    
    private func commentTextChanged(_ text: String) {
        state.commentText = text
    }
    
    private func pickerStateChanged(_ pickerState: Int) async {
        state.pickerState = pickerState
        switch pickerState{
        case State.PickerState.file.rawValue: await photoPickerItemChanged(nil)
        case State.PickerState.image.rawValue: fileURLChanged(nil)
        default: break
        }
    }
    
    private func photoPickerPresentedChanged(_ presented: Bool) {
        state.photoPickerPresented = presented
    }
    
    private func photoPickerItemChanged(_ item: PhotosPickerItem?) async {
        state.photoPickerItem = item
        state.loadedImage = try? await item?.loadTransferable(type: Image.self)
    }
    
    private func fileImporterPresentedChanged(_ presented: Bool) {
        state.fileImporterPresented = presented
    }
    
    private func fileURLChanged(_ url: URL?) {
        state.fileURL = url
    }
    
    private func dismissAlert() {
        state.alertData = nil
    }
}
