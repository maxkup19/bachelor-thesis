//
//  StudentsView.swift
//  
//
//  Created by Maksym Kupchenko on 20.02.2024.
//

import SwiftUI
import UIToolkit

struct StudentsView: View {
    
    @ObservedObject private var viewModel: StudentsViewModel
    
    init(viewModel: StudentsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.state.students.isEmpty {
                ContentUnavailableView(
                    "No Students",
                    systemImage: "person.2.slash.fill",
                    description: Text("You have no students\nWould you like to add any? Tap the + button on top")
                )
            } else {
                List {
                    ForEach(viewModel.state.students.sorted(by: { $0.name > $1.name })) { student in
                        StudentRowView(student: student)
                            .padding(.vertical, AppTheme.Dimens.spaceMedium)
                    }
                    .onDelete(perform: {_ in })
                }
                .listStyle(.plain)
            }
        }
        .refreshable(action: { viewModel.onIntent(.refresh) })
        .navigationTitle("Students")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { viewModel.onIntent(.showAddStudentDialogue(true)) }) {
                    AppTheme.Images.plus
                }
            }
            
            
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
#warning("TODO: add filter and sorting")
                } label: {
                    AppTheme.Images.dots
                }
            }
        }
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
        .alert(
            "Add Student",
            isPresented: Binding(
                get: { viewModel.state.showAddStudentDialogue },
                set: { value in viewModel.onIntent(.showAddStudentDialogue(value)) }
            ), actions: {
                TextField(
                    "Email",
                    text: Binding(
                        get: { viewModel.state.addStudentEmail },
                        set: { email in viewModel.onIntent(.emailChanged(email)) }
                    ),
                    prompt: Text("Email")
                )
                .autocorrectionDisabled(false)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                
                Button("Cancel", role: .cancel) { }
                Button("Add") {
                    viewModel.onIntent(.addStudent)
                }
        }, message: {
        })
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
    
    let vm = StudentsViewModel(flowController: nil)
    return StudentsView(viewModel: vm)
}

#endif
