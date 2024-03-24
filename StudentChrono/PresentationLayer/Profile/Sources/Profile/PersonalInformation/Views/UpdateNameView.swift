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
    private let updateName: () -> Void
    
    private let textWidth: CGFloat = 50
    
    init(
        name: Binding<String>,
        lastName: Binding<String>,
        updateName: @escaping () -> Void
    ) {
        self._name = name
        self._lastName = lastName
        self.updateName = updateName
    }
    
    var body: some View {
        Form {
            HStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
                Text("First")
                    .frame(width: textWidth, alignment: .leading)
                    
                TextField(
                    text: $name,
                    prompt: Text("Required"),
                    label: { }
                )
            }
            
            HStack(spacing: AppTheme.Dimens.spaceXXXLarge) {
                Text("Last")
                    .frame(width: textWidth, alignment: .leading)
                
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
                    updateName()
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
        updateName: { }
    )
}
#endif
