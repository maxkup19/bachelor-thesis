//
//  AddTaskDetailsView.swift
//
//
//  Created by Maksym Kupchenko on 27.02.2024.
//

import SharedDomain
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
                Section {
                    FoldableDatePicker(date: $taskDetails.dueTo)
                }
                
                Section {
                    Picker(
                        selection: $taskDetails.priority) {
                            ForEach(Priority.allCases) { value in
                                Text(value.rawValue.capitalized)
                                    .tag(value)
                                if value == .none {
                                    Divider()
                                }
                            }
                        } label: {
                            HStack {
                                FormImage(
                                    .rectangle,
                                    image: AppTheme.Images.exclamationmark,
                                    color: .red
                                )
                                
                                Text("Priority")
                                    .font(.callout)
                            }
                        }
                }
                
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
