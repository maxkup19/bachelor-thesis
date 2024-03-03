//
//  RegistrationInputView.swift.swift
//
//
//  Created by Maksym Kupchenko on 23.02.2024.
//

import SwiftUI
import UIToolkit

struct RegistrationInputView: View, KeyboardReadable {
    
    enum Field: Hashable {
        case name
        case lastName
        case birthDay
        case email
        case password
        case confirmPassword
    }
    
    @Binding private var name: String
    @Binding private var lastName: String
    @Binding private var email: String
    @Binding private var dateOfBirth: Date
    @Binding private var password: String
    @Binding private var confirmedPassword: String
    
    @FocusState private var focusedField: Field?
    
    @State private var isKeyboardVisible = false
    @State private var shouldKeyboardOpen: Bool = false
    
    init(
        name: Binding<String>,
        lastName: Binding<String>,
        email: Binding<String>,
        dateOfBirth: Binding<Date>,
        password: Binding<String>,
        confirmedPassword: Binding<String>
    ) {
        self._name = name
        self._lastName = lastName
        self._email = email
        self._dateOfBirth = dateOfBirth
        self._password = password
        self._confirmedPassword = confirmedPassword
    }
    
    var body: some View {
        Form {
            Section("Personal Information") {
                TextField(
                    "Name",
                    text: $name,
                    prompt: Text("Name")
                )
                .focused($focusedField, equals: .name)
                .submitLabel(.next)
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.words)
                .onSubmit {
                    focusedField = .lastName
                }
                
                TextField(
                    "Lastname",
                    text: $lastName,
                    prompt: Text("Lastname")
                )
                .focused($focusedField, equals: .lastName)
                .submitLabel(.next)
                .keyboardType(.asciiCapable)
                .textInputAutocapitalization(.words)
                .onSubmit {
                    focusedField = .email
                }
                
                TextField(
                    "Email",
                    text: $email,
                    prompt: Text("Email")
                )
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .onSubmit {
                    focusedField = .birthDay
                }
                
                DatePicker(
                    "Birthday",
                    selection: $dateOfBirth,
                    displayedComponents: .date
                )
                .focused($focusedField, equals: .birthDay)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
            }
            
            Section("Passwords") {
                SecureField(
                    "Password",
                    text: $password,
                    prompt: Text("Password")
                )
                .focused($focusedField, equals: .password)
                .autocorrectionDisabled()
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .confirmPassword
                }
                
                SecureField(
                    "Confirm Password",
                    text: $confirmedPassword,
                    prompt: Text("Confirm Password")
                )
                .focused($focusedField, equals: .confirmPassword)
                .autocorrectionDisabled()
                .submitLabel(.done)
                .onSubmit {
                    focusedField = nil
                }
                .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                    if shouldKeyboardOpen {
                        focusedField = .confirmPassword
                        shouldKeyboardOpen = false
                    }
                    isKeyboardVisible = newIsKeyboardVisible
                }
            }
        }
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
    }
}

#Preview {
    RegistrationInputView(
        name: .constant(""),
        lastName: .constant(""),
        email: .constant(""),
        dateOfBirth: .constant(.now),
        password: .constant(""),
        confirmedPassword: .constant("")
    )
}
