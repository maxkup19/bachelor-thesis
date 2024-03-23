//
//  TasksList.swift
//
//
//  Created by Maksym Kupchenko on 23.03.2024.
//

import SwiftUI
import SharedDomain

public struct TasksList: View {
    
    @Environment(\.isLoading) private var isLoading
    
    private let tasks: [SharedDomain.Task]
    private let onTaskTap: (String) -> Void
    private let onRefresh: (() -> Void)?
    
    public init(
        tasks: [SharedDomain.Task],
        onTaskTap: @escaping (String) -> Void,
        onRefresh: (() -> Void)? = nil
    ) {
        self.tasks = tasks
        self.onTaskTap = onTaskTap
        self.onRefresh = onRefresh
    }
    
    public var body: some View {
        if isLoading {
            List {
                ForEach(TaskState.allCases) { taskState in
                    Section("\(taskState.emoji) \(taskState.title)") {
                        TaskRowView()
                    }
                }
            }
            .environment(\.isLoading, true)
            .disabled(true)
        } else if !tasks.isEmpty {
            List {
                ForEach(TaskState.allCases) { taskState in
                    let tasks = tasks.filter { $0.state == taskState }
                    
                    if !tasks.isEmpty {
                        Section("\(taskState.emoji) \(taskState.title)") {
                            ForEach(tasks) { task in
                                TaskRowView(task: task)
                                    .onTapGesture {
                                        onTaskTap(task.id)
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .refreshable {
                onRefresh?()
            }
        }
    }
}

#if DEBUG
import SharedDomainMocks

#Preview {
    TasksList(
        tasks: [.task1Stub, .task2Stub],
        onTaskTap: { _ in },
        onRefresh: nil
    )
}
#endif
