//
//  TaskDetailView.swift
//
//
//  Created by Maksym Kupchenko on 07.03.2024.
//

import SwiftUI
import UIToolkit

struct TaskDetailView: View {
    
    @Environment(\.openURL) private var openURL
    
    @ObservedObject private var viewModel: TaskDetailViewModel
    
    let size: CGFloat = 60
    
    init(viewModel: TaskDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: AppTheme.Dimens.spaceLarge) {
                    TaskDetailHeaderView(task: viewModel.state.task)
                    
                    Text("**Current State**: \(viewModel.state.task.state.emoji) \(viewModel.state.task.state.title)")
                    
                    Text("Elaboration")
                        .font(.title2)
                        .foregroundStyle(Color.primary)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
            .background(Color(UIColor.systemBackground))
            
            if viewModel.state.task.comments.isEmpty {
                
                ContentUnavailableView(
                    "Elaboration wasn't started yet...",
                    systemImage: "text.book.closed"
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))
                
            } else {
                ForEach(viewModel.state.task.comments) { comment in
                    Section {
                        TextField("Comment", text: .constant(comment.text), axis: .vertical)
                            .disabled(true)
                            .lineLimit(nil)
                        if let attachment = URL(string: comment.fileLink ?? "") {
                            Link("Attachment", destination: attachment)
                        }
                    } header: {
                        Text(viewModel.state.user.id == comment.author.id ? "You" : comment.author.fullName)
                    } footer: {
                        if let createdAt = comment.createdAt{
                            Text(createdAt.formatted(date: .abbreviated, time: .shortened))
                        }
                    }
                }
            }
            
            Section {
                Button("Add Comment") {
                    viewModel.onIntent(.addComment)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                // TODO: submit button for student and review button for teacher
            }
        }
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
        .alert(item: Binding<AlertData?>(
            get: { viewModel.state.alertData },
            set: { _ in viewModel.onIntent(.dismissAlert) }
        )) { alert in .init(alert) }
    }
}

#if DEBUG
import DependencyInjectionMocks
import Factory

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = TaskDetailViewModel(taskId: "", flowController: nil)
    return TaskDetailView(viewModel: vm)
}
#endif

extension URL: Identifiable {
    
    public var id: String { absoluteString }
}
