//
//  FeedbackView.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import PhotosUI
import SwiftUI
import UIToolkit

struct FeedbackView: View {
    
    @ObservedObject private var viewModel: FeedbackViewModel
    
    init(viewModel: FeedbackViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        Form {
            
            ScreenshotSection(
                showAddButton: viewModel.state.loadedImage == nil,
                image: viewModel.state.loadedImage,
                onAddTap: { viewModel.onIntent(.addScreenshotTap) },
                onRemoveTap: { viewModel.onIntent(.photoPickerItemChanged(nil)) }
            )
            
            Section("Email") {
                TextField("Email", text: .constant(viewModel.state.userEmail))
            }
            
            Section("Description (mandatory)") {
                TextField(
                    "Description",
                    text: Binding(
                        get: { viewModel.state.feedbackDescription },
                        set: { description in viewModel.onIntent(.feedbackDescriptionChanged(description)) }
                    ),
                    prompt: Text("Comment, kind words, etc."),
                    axis: .vertical
                )
                .lineLimit(4...)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Submit") {
                    viewModel.onIntent(.submitFeedback)
                }
                .bold()
            }
        }
        .photosPicker(
            isPresented: Binding(
                get: { viewModel.state.photoPickerPresented },
                set: { changed in viewModel.onIntent(.photoPickerPresentedChanged(changed)) }
            ),
            selection: Binding(
                get: { viewModel.state.photoPickerItem },
                set: { item in viewModel.onIntent(.photoPickerItemChanged(item)) }
            )
        )
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alertData },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
    }
}

#if DEBUG
import Factory
import DependencyInjectionMocks

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = FeedbackViewModel(flowController: nil)
    return FeedbackView(viewModel: vm)
}
#endif
