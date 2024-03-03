//
//  StudentSelectionList.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import SwiftUI
import SharedDomain

struct StudentSelectionList: View {
    
    @Binding private var assignee: Set<User.ID>
    private let users: [User]
    
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
                List(users, selection: $assignee) { user in
                    Text(user.name)
                }
                .environment(\.editMode, .constant(.active))
            }
        }
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