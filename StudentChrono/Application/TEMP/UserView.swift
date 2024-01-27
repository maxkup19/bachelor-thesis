//
//  UserView.swift
//  StudentChrono
//
//  Created by Maksym Kupchenko on 26.01.2024.
//

import SwiftUI
import UIToolkit

struct UsersView: View {
    
    @ObservedObject private var viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ContentUnavailableView("NO CONTENT", image: "clock")
    }
}

#if DEBUG
import Factory

#Preview {
    
    let vm = UsersViewModel(flowController: nil)
    return UsersView(viewModel: vm)
}
#endif
