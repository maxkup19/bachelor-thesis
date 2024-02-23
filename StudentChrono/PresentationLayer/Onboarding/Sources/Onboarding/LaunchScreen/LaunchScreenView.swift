//
//  LaunchScreenView.swift
//
//
//  Created by Maksym Kupchenko on 22.02.2024.
//

import SwiftUI
import UIToolkit

struct LaunchScreenView: View {
    
    @ObservedObject private var viewModel: LaunchScreenViewModel
    
    private let appIconSize: CGFloat = 120
    
    init(viewModel: LaunchScreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            AppTheme.Images.appIcon
                .resizable()
                .frame(width: 120, height: 120)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .lifecycle(viewModel)
    }
}

#Preview {
    LaunchScreenView(viewModel: LaunchScreenViewModel(flowController: nil))
}
