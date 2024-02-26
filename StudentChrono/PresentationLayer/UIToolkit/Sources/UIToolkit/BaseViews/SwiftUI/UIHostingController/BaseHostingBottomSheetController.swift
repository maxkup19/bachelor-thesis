//
//  BaseHostingBottomSheetController.swift
//
//
//  Created by Maksym Kupchenko on 26.02.2024.
//

import Foundation
import SwiftUI

public class BaseHostingBottomSheetController<Content: View>: BaseHostingController<AnyView> {
    
    // The reason to doing this way is, that we need dismiss action on tap outside the contentView.
    // This is kinda hack but it is working.
    public init(rootView: Content, dismissTap: @escaping () -> Void) {
        var body: some View {
            BottomSheetView(dismiss: dismissTap) {
                rootView
            }
        }
        
        super.init(rootView: AnyView(body))
        view.backgroundColor = .clear
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
