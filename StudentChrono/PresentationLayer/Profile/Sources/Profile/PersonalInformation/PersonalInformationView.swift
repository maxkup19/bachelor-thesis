//
//  PersonalInformationView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI

struct PersonalInformationView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding private var name: String
    @Binding private var lastName: String
    @Binding private var birthDay: Date
    private let updateInfo: () -> Void
    private let verifyName: () -> Void
    
    @State private var showDatePicker: Bool = false
    
    public init(
        name: Binding<String>,
        lastName: Binding<String>,
        birthDay: Binding<Date>,
        updateInfo: @escaping () -> Void,
        verifyName: @escaping () -> Void
    ) {
        self._name = name
        self._lastName = lastName
        self._birthDay = birthDay
        self.updateInfo = updateInfo
        self.verifyName = verifyName
    }
    
    var body: some View {
        Form {
            NavigationLink {
                UpdateNameView(
                    name: $name,
                    lastName: $lastName,
                    verifyName: verifyName
                )
            } label: {
                HStack {
                    Text("Name")
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    Text("\(name) \(lastName)")
                        .foregroundStyle(Color.secondary)
                }
            }
            
            Button {
                withAnimation {
                    showDatePicker.toggle()
                }
            } label: {
                HStack {
                    Text("Date of birth")
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    Text(birthDay.formatted(date: .numeric, time: .omitted))
                        .foregroundStyle(Color.secondary)
                }
            }
            
            
            if showDatePicker {
                DatePicker(
                    "Date of birth",
                    selection: $birthDay,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
            }
        }
        .navigationTitle("Personal Information")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    updateInfo()
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

#if DEBUG
import SharedDomain
import SharedDomainMocks

#Preview {
    PersonalInformationView(
        name: .constant(User.studentStub.name),
        lastName: .constant(User.studentStub.lastName),
        birthDay: .constant(User.studentStub.birthDay),
        updateInfo: { },
        verifyName: { }
    )
}
#endif
