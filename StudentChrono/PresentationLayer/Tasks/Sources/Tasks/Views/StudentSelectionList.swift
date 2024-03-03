//
//  StudentSelectionList.swift
//  
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import SwiftUI
import SharedDomain

struct StudentSelectionList: View {
    
    @Binding private var assigneeIds: Set<String>
    private let users: [User]
    
    init(
        assigneeIds: Binding<Set<String>>,
        users: [User]
    ) {
        self._assigneeIds = assigneeIds
        self.users = users
    }
    
    var body: some View {
        NavigationStack {
            List(users, selection: $assigneeIds) { user in
                Text(user.name)
            }
            .environment(\.editMode, .constant(.active))
        }
    }
}

#if DEBUG
import SharedDomainMocks

#Preview {
    StudentSelectionList(
        assigneeIds: .constant([User.studentStub.id]),
        users: [.studentStub, .teacherStub]
    )
}

#endif
