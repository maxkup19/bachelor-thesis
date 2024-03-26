//
//  AddComentView.swift
//
//
//  Created by Maksym Kupchenko on 26.03.2024.
//

import SwiftUI
import UIToolkit
import UIKit

struct AddComentView: View {
    
    @ObservedObject private var viewModel: AddCommentViewModel
    
    init(viewModel: AddCommentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Section {
                TextField(
                    "Comment",
                    text: Binding(
                        get: { viewModel.state.commentText },
                        set: { text in viewModel.onIntent(.commentTextChanged(text)) }
                    ),
                    axis: .vertical
                )
                .lineLimit(4...)
            }
            
            Picker(
                "Attachment Type",
                selection: Binding(
                    get: { viewModel.state.pickerState },
                    set: { state in viewModel.onIntent(.pickerStateChanged(state)) }
                )
            ) {
                ForEach(AddCommentViewModel.State.PickerState.allCases) { state in
                    Text(state.title)
                        .tag(state.id)
                }
            }
            
            if viewModel.state.photoPickerItem == nil && viewModel.state.fileURL == nil {
                Button("Add Attachment", action: { viewModel.onIntent(.addAttachmentTap) })
            } else {
                Button("Delete Attachment", role: .destructive, action: { viewModel.onIntent(.removeAttachmentTap) })
            }
            
            if let image = viewModel.state.loadedImage {
                image
                    .resizable()
                    .scaledToFit()
            }
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("**Submit**") {
                    viewModel.onIntent(.submit)
                }
                .disabled(viewModel.state.commentText.isEmpty)
            }
        }
        .fileImporter(
            isPresented: Binding(
                get: { viewModel.state.fileImporterPresented },
                set: { presented in viewModel.onIntent(.fileImporterPresentedChanged(presented)) }
            ),
            allowedContentTypes: [.pdf]
        ) { result in
            switch result {
            case .success(let url): viewModel.onIntent(.fileURLChanged(url))
            case .failure: viewModel.onIntent(.fileURLChanged(nil))
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
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = AddCommentViewModel(taskId: "1", flowController: nil)
    return AddComentView(viewModel: vm)
}
#endif
