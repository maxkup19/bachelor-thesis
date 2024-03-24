//
//  PersonalInformationView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI
import UIToolkit

struct PersonalInformationView: View {
    
    @ObservedObject private var viewModel: PersonalInformationViewModel
    
    init(viewModel: PersonalInformationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            NavigationLink {
                UpdateNameView(
                    name: Binding(
                        get: { viewModel.state.name },
                        set: { value in viewModel.onIntent(.nameChanged(value)) }
                    ),
                    lastName: Binding(
                        get: { viewModel.state.lastName },
                        set: { value in viewModel.onIntent(.lastNameChanged(value)) }
                    ),
                    updateName: { viewModel.onIntent(.updateUserName) }
                )
            } label: {
                HStack {
                    Text("Name")
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    Text("\(viewModel.state.name) \(viewModel.state.lastName)")
                        .foregroundStyle(Color.secondary)
                }
            }
            
            Button(action: { viewModel.onIntent(.showDatePickerTap) }) {
                HStack {
                    Text("Date of birth")
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    Text(viewModel.state.birthDay.formatted(date: .numeric, time: .omitted))
                        .foregroundStyle(Color.secondary)
                }
            }
            
            
            if viewModel.state.showDatePicker {
                DatePicker(
                    "Date of birth",
                    selection: Binding(
                        get: { viewModel.state.birthDay },
                        set: { value in viewModel.onIntent(.birthDayChanged(value)) }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
            }
        }
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
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
    
    let vm = PersonalInformationViewModel(flowController: nil)
    return PersonalInformationView(viewModel: vm)
}
#endif
