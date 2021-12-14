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
        VStack {
            title
        }
    }
    private var title: some View {
        Text(topic.title)
            .fontWeight(.bold)
    }
}
