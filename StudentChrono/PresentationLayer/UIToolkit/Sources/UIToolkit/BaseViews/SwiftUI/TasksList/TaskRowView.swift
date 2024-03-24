//
//  TaskRowView.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SharedDomain
import SharedDomainMocks
import SwiftUI

struct TaskRowView: View {
    
    @Environment(\.isLoading) private var isLoading
    
    private let task: SharedDomain.Task
    
    private let imageSize: CGFloat = 15
    
    init(task: SharedDomain.Task = .task1Stub) {
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
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        Text("Author · \(task.author.name) \(task.author.lastName)")
                    }
                    
                    HStack {
                        Image(systemName: "chevron.down.square")
                            .resizable()
                            .frame(width: imageSize, height: imageSize)
                        Text("Status · \(task.state.emoji) \(task.state.title)")
                    }
                    
                    if let assignee = task.assignee {
                        HStack {
                            Image(systemName: "person")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
                            Text("Assignee · \(assignee.name) \(assignee.lastName)")
                        }
                    }
                    
                    if !task.tags.isEmpty {
                        HStack {
                            Image(systemName: "tag")
                                .resizable()
                                .frame(width: imageSize, height: imageSize)
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
                        .foregroundStyle(deadline > .now ? Color.primary : Color.red)
                }
            }
        }
        .skeleton(isLoading)
    }
}

#if DEBUG
import SharedDomainMocks

#Preview {
    List {
        TaskRowView()
        TaskRowView()
    }
}
#endif
