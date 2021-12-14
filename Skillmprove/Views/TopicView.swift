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
            image
            title
        }
    }
    private var image: some View {
        AsyncImage(url: topic.url, transaction: Transaction(animation: .easeInOut)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .cornerRadius(16)
            case .failure:
                #warning("Add default image")
                Text("Something went wrong")
            @unknown default:
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .aspectRatio(1.0, contentMode: .fill)
    }
    private var title: some View {
        Text(topic.title)
            .fontWeight(.bold)
    }
}

struct TopicView_Previews: PreviewProvider {
    static var previews: some View {
        TopicView(topic: .init(
            url: URL(string: "https://i08.fotocdn.net/s107/5fe81d48e05fc40b/public_pin_l/2317048272.jpg")!,
            title: "Swift"
        ))
    }
}
