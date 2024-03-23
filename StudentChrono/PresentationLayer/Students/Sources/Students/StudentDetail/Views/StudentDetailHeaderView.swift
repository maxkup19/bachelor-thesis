//
//  StudentDetailHeaderView.swift
//
//
//  Created by Maksym Kupchenko on 24.03.2024.
//

import SwiftUI
import UIToolkit

struct StudentDetailHeaderView: View {
    
    private let imageURL: String
    private let fullName: String
    private let email: String
    
    private let size: CGFloat = 80
    
    init(
        imageURL: String?,
        fullName: String,
        email: String
    ) {
        self.imageURL = imageURL ?? ""
        self.fullName = fullName
        self.email = email
    }
    
    var body: some View {
        HStack(spacing: AppTheme.Dimens.spaceMedium) {
            AsyncImage(url: URL(string: imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error == nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                }
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(fullName)
                    .font(.title2)
                    .foregroundStyle(Color.primary)
                
                Text(email)
                    .font(.headline)
                    .foregroundStyle(Color.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#if DEBUG
import SharedDomain
import SharedDomainMocks

#Preview {
    StudentDetailHeaderView(
        imageURL: User.studentStub.imageURL,
        fullName: User.studentStub.fullName,
        email: User.studentStub.email
    )
}
#endif
