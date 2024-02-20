//
//  ToastViewModifier.swift
//
//
//  Created by Maksym Kupchenko on 12.02.2024.
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    
    @Binding private(set) var toastData: ToastData?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                mainToastView
                    .offset(y: -30)
                    .animation(.spring(), value: toastData)
            )
            .onChange(of: toastData) {
                showToast()
            }
        
    }
    
    private var mainToastView: some View {
        VStack {
            Spacer()
            if let toastData = toastData {
                ToastView(ToastData(toastData.title, style: toastData.style))
            }
        }
        .transition(.opacity)
    }
    
    private func showToast() {
        guard let toastData = toastData else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toastData.hideAfter > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toastData.hideAfter, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toastData = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
