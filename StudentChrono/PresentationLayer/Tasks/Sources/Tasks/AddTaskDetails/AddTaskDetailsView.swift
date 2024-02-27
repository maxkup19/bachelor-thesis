//
//  AddTaskDetailsView.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SwiftUI
import UIToolkit

struct AddTaskDetailsView: View {
    
    @Binding private var taskDetails: TaskDetails
    private let addButtonDisabled: Bool
    private let onAddButtonTap: () -> Void
    
    init(
        taskDetails: Binding<TaskDetails>,
        addButtonDisabled: Bool,
        onAddButtonTap: @escaping () -> Void
    ) {
        self._taskDetails = taskDetails
        self.addButtonDisabled = addButtonDisabled
        self.onAddButtonTap = onAddButtonTap
    }
    
    var body: some View {
        NavigationStack {
            Form {
                FoldableDatePicker(date: $taskDetails.dueTo)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("**Add**") {
                        onAddButtonTap()
                    }
                    .disabled(addButtonDisabled)
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#if DEBUG

#Preview {
    AddTaskDetailsView(
        taskDetails: .constant(TaskDetails()),
        addButtonDisabled: false,
        onAddButtonTap: { }
    )
}
#endif
