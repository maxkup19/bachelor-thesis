//
//  ProfileHeaderView.swift
//
//
//  Created by Maksym Kupchenko on 04.03.2024.
//

import SwiftUI
import UIToolkit

struct ProfileHeaderView: View {
    
    @Environment(\.isLoading) private var isLoading
    
    private let imageURL: String?
    private let fullName: String
    private let email: String
    private let onImageTap: () -> Void
    
    private let size: CGFloat = 100
    
    public init(
        imageURL: String?,
        fullName: String,
        email: String,
        onImageTap: @escaping () -> Void
    ) {
        self.imageURL = imageURL
        self.fullName = fullName
        self.email = email
        self.onImageTap = onImageTap
    }
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error == nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                }
            }
            .frame(width: size, height: size)
            .clipShape(Circle())
            .onLongPressGesture {
                onImageTap()
            }
            
            Text(fullName)
                .font(.title)
                .foregroundStyle(Color.primary)
            
            Text(email)
                .font(.title3)
                .foregroundStyle(Color.secondary)
        }
        .skeleton(isLoading)
    }
    
}

#if DEBUG
import SharedDomainMocks

#Preview {
    ProfileHeaderView(
        imageURL: User.studentStub.imageURL,
        fullName: User.studentStub.fullName,
        email: User.studentStub.email,
        onImageTap: { }
    )
}

#endif
