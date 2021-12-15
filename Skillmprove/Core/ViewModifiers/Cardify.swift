//
//  Cardify.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 15.12.21.
//

import SwiftUI

struct Cardify: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
            content
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
}

extension View {
    func cardify() -> some View {
        modifier(Cardify())
    }
}
