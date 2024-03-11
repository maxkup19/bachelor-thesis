//
//  FeedbackView.swift
//
//
//  Created by Maksym Kupchenko on 11.03.2024.
//

import PhotosUI
import SwiftUI
import UIToolkit

struct FeedbackView: View {
    
    @ObservedObject private var viewModel: FeedbackViewModel
    
    init(viewModel: FeedbackViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Feedback")
        }
//        .photosPicker(
//            isPresented: $photoPickerIsPresented,
//            selection: $photoPickerItem
//        )
    }
}

#if DEBUG
import Factory
import DependencyInjectionMocks

#Preview {
    Container.shared.registerUseCaseMocks()
    
    let vm = FeedbackViewModel(flowController: nil)
    return FeedbackView(viewModel: vm)
}
#endif
