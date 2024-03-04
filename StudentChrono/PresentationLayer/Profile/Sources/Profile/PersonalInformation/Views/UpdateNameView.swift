//
//  UdpateNameView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI
import UIToolkit

struct UpdateNameView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding private var name: String
    @Binding private var lastName: String
    private let verifyName: () -> Void
    
    init(
        name: Binding<String>,
        lastName: Binding<String>,
        verifyName: @escaping () -> Void
    ) {
        self._name = name
        self._lastName = lastName
        self.verifyName = verifyName
    }
    
    var body: some View {
        Form {
            HStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
                Text("First")
                    
                TextField(
                    text: $name,
                    prompt: Text("Required"),
                    label: { }
                )
            }
            
            HStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
                Text("Last")
                    
                TextField(
                    text: $lastName,
                    prompt: Text("Required"),
                    label: { }
                )
            }
        }
        .navigationTitle("Name")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    verifyName()
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
    UpdateNameView(
        name: .constant(User.studentStub.name),
        lastName: .constant(User.studentStub.lastName),
        verifyName: { }
    )
}
#endif
