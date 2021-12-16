//
//  PopupView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct PopupView<T>: ViewModifier where T: View {
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    let popup: () -> T
    let isPresented: Bool
    let alignment: Alignment
    
    init(isPresented: Bool, alignment: Alignment, @ViewBuilder content: @escaping () -> T) {
        self.isPresented = isPresented
        self.alignment = alignment
        popup = content
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
//                if isPresented {
                    viewControllerHolder?.present(style: .fullScreen, builder: {
                        popup()
                    })
//                }
            }
    }
    
    @ViewBuilder
    private func popupContent() -> some View {
        GeometryReader { geometry in
            if isPresented {
                popup()
                    .transition(.opacity)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: alignment)
            }
        }
    }
}

extension View {
    func popup<T: View>(
        isPresented: Bool,
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> T
    ) -> some View {
        modifier(PopupView(isPresented: isPresented, alignment: alignment, content: content))
    }
    func popup<T: View, Item: Identifiable>(
        item: Item?,
        alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> T
    ) -> some View {
        popup(isPresented: item != nil, alignment: alignment, content: content)
    }
}
