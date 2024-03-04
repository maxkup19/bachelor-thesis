//
//  PersonalInformationView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI

struct PersonalInformationView: View {
    
    @Binding private var name: String
    @Binding private var lastName: String
    @Binding private var birthDay: Date
    private let onDisappear: () -> Void
    
    @State private var showDatePicker: Bool = false
    
    public init(
        name: Binding<String>,
        lastName: Binding<String>,
        birthDay: Binding<Date>,
        onDisappear: @escaping () -> Void
    ) {
        self._name = name
        self._lastName = lastName
        self._birthDay = birthDay
        self.onDisappear = onDisappear
    }
    
    var body: some View {
        Form {
            NavigationLink {
                
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
        .onDisappear(perform: onDisappear)
    }
}

#if DEBUG
import SharedDomain
import SharedDomainMocks

#Preview {
    PersonalInformationView(
        name: .constant(User.studentStub.name),
        lastName: .constant(User.studentStub.lastName),
        birthDay: .constant(User.studentStub.birthDay)
    )
}
#endif
