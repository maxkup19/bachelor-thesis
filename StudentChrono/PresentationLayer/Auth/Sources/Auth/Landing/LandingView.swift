//
//  LandingView.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI
import UIToolkit

struct LandingView: View {
    
    @ObservedObject private var viewModel: LandingViewModel
    
    init(viewModel: LandingViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geo in
            AppTheme.Images.appIcon
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .ignoresSafeArea()
        .environment(\.isLoading, viewModel.state.isLoading)
        .lifecycle(viewModel)
    }
}

#Preview {
    LandingView(viewModel: LandingViewModel(flowController: nil))
}
