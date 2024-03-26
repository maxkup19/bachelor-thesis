//
//  StudentSelectionList.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import SharedDomain
import SwiftUI
import UIToolkit

struct StudentSelectionList: View {
    
    @Binding private var assignee: Set<User.ID>
    private let users: [User]
    
    private let imageSize: CGFloat = 60
    
    init(
        assignee: Binding<Set<User.ID>>,
        users: [User]
    ) {
        self._assignee = assignee
        self.users = users
    }
    
    var body: some View {
        Group {
            if users.isEmpty {
                ContentUnavailableView(
                    "No Students",
                    systemImage: "person.2.slash.fill",
                    description: Text("You have no students\nWould you like to find any? Go to Students tab")
                )
            } else {
                List(users, selection: $assignee) { student in
                    HStack(spacing: AppTheme.Dimens.spaceLarge) {
                        AsyncImage(url: URL(string: student.imageURL ?? "")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } else if phase.error == nil {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                            }
                        }
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text(student.fullName)
                                .foregroundStyle(Color.primary)
                            
                            Text(student.email)
                                .foregroundStyle(Color.secondary)
                        }
                        
                    }
                }
                .environment(\.editMode, .constant(.active))
                .listStyle(.plain)
            }
        }
        .navigationTitle("Students")
    }
}

#if DEBUG
import SharedDomainMocks

#Preview {
    StudentSelectionList(
        assignee: .constant([User.studentStub.id]),
        users: [.studentStub, .teacherStub]
    )
}

#endif
