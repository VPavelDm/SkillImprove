//
//  TopicView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import SwiftUI

struct TopicView: View {
    var topic: Topic
    
    // MARK: - Views
    var body: some View {
        ZStack {
            title
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fill)
        .background(
            LinearGradient(colors: topic.card.backgroundColors, startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(16)
    }
    private var title: some View {
        Text(topic.title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(topic.card.textColor)
    }
}
