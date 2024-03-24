//
//  TaskDetailHeaderView.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import SharedDomain
import SwiftUI
import UIToolkit

struct TaskDetailHeaderView: View {
    
    private let task: Task
    
    private let size: CGFloat = 60
    
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        Group {
            Text(task.title)
                .font(.title3)
                .foregroundStyle(Color.primary)
            
            HStack(spacing: AppTheme.Dimens.spaceMedium) {
                AsyncImage(url: URL(string: task.assignee?.imageURL ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else if phase.error == nil {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                    }
                }
                .frame(width: size, height: size)
                .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(task.assignee?.fullName ?? "")
                        .bold()
                    
                    Spacer()
                    
                    if let createdAt = task.createdAt {
                        Text("Created \(createdAt.formatted(date: .numeric, time: .omitted))")
                    }
                    
                    Spacer()
                    
                    if let dueTo = task.dueTo {
                        Text("Due to \(dueTo.formatted(date: .numeric, time: .omitted))")
                    }
                    
                }
                .font(.subheadline)
                .foregroundStyle(Color.primary)
                
            }
            .frame(height: size)
            
            Text(task.description)
                .font(.headline)
                .foregroundStyle(Color.secondary)
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
import SharedDomainMocks

#Preview {
    TaskDetailHeaderView(task: Task.task2Stub)
}
#endif
