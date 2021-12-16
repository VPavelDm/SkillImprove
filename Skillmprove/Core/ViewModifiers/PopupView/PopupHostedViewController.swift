//
//  PopupHostedViewController.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 16.12.21.
//

import UIKit
import SwiftUI

class PopupHostedViewController<PopupView>: UIHostingController<PopupView> where PopupView: View {
    
    var isPresented: Binding<Bool>
    
    init(isPresented: Binding<Bool>, rootView: PopupView) {
        self.isPresented = isPresented
        super.init(rootView: rootView)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        isPresented.wrappedValue = false
    }
    
}
