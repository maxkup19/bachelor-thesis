//
//  StudentRowView.swift
//
//
//  Created by Maksym Kupchenko on 18.03.2024.
//

import SharedDomain
import SwiftUI
import UIToolkit

struct StudentRowView: View {
    
    private let student: User
    
    private let imageSize: CGFloat = 60
    
    init(student: User) {
        self.student = student
    }
    
    var body: some View {
        HStack(spacing: AppTheme.Dimens.spaceLarge) {
            AsyncImage(url: URL(string: student.imageURL ?? "")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error == nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                }
            }
            .frame(width: imageSize, height: imageSize)
            .clipShape(Circle())
            
            Text(student.fullName)
                .foregroundStyle(Color.primary)
                .font(.title3)
        }
    }
}

#if DEBUG
import SharedDomainMocks

#Preview {
    StudentRowView(student: User.studentStub)
}
#endif
