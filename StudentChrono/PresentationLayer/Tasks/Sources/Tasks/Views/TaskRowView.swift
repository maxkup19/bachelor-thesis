//
//  TaskRowView.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SharedDomain
import SwiftUI
import UIToolkit

struct TaskRowView: View {
    
    typealias Task = SharedDomain.Task
    
    private let task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        HStack(alignment: .top) {
            task.state.imageStatus
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading) {
                Text(task.title)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "rectangle.inset.filled.and.person.filled")
                        Text("Author · \(task.author.name) \(task.author.lastName)")
                    }
                    
                    HStack {
                        Image(systemName: "chevron.down.square")
                        Text("Status · \(task.state.emoji) \(task.state.title)")
                    }
                    
                    if let assignee = task.assignee {
                        HStack {
                            Image(systemName: "person")
                            Text("Assignee · \(assignee.name) \(assignee.lastName)")
                        }
                    }
                    
                    if !task.tags.isEmpty {
                        HStack {
                            Image(systemName: "tag")
                            Text("Tags ·")
                            ForEach(task.tags, id: \.self) { tag in
                                Text(tag)
                            }
                        }
                    }
                }
                .font(.footnote)
                .foregroundStyle(Color.gray)
                .padding(AppTheme.Dimens.spaceSmall)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                if let deadline = task.dueTo {
                    Text("Deadline: \(deadline.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                }
            }
        }
    }
}

#if DEBUG

#Preview {
    List {
        TaskRowView(task: Task.task1Stub)
        TaskRowView(task: Task.task2Stub)
    }
}
#endif
