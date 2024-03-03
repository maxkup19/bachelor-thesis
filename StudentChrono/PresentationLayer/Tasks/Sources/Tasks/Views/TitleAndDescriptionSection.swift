//
//  TitleAndDescriptionSection.swift
//
//
//  Created by Maksym Kupchenko on 03.03.2024.
//

import SwiftUI

struct TitleAndDescriptionSection: View {
    
    @Binding private var title: String
    @Binding private var description: String
    
    init(
        title: Binding<String>,
        description: Binding<String>
    ) {
        self._title = title
        self._description = description
    }
    
    var body: some View {
        Section {
            TextField(
                "Title",
                text: $title,
                axis: .vertical
            )
            
            TextField(
                "Description",
                text: $description,
                axis: .vertical
            )
            .lineLimit(4...)
        }
    }
}

#if DEBUG

#Preview {
    TitleAndDescriptionSection(
        title: .constant("Title"),
        description: .constant("Description")
    )
}

#endif
