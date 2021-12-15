//
//  NavigationBarTransparancy.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

private struct NavigationBarTransparancy: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithDefaultBackground()
                UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            }
    }
}
extension View {
    func disableNavigationBarTransparancy() -> some View {
        modifier(NavigationBarTransparancy())
    }
}
