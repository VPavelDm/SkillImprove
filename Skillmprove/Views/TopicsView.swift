//
//  TopicsView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import SwiftUI
import CoreData

struct TopicsView: View {
    
    var topics: [Topic] = [
        .init(
            url: URL(string: "https://i08.fotocdn.net/s107/5fe81d48e05fc40b/public_pin_l/2317048272.jpg")!,
            title: "Swift"
        ),
        .init(
            url: URL(string: "https://i08.fotocdn.net/s107/5fe81d48e05fc40b/public_pin_l/2317048272.jpg")!,
            title: "UIKit"
        ),
        .init(
            url: URL(string: "https://i08.fotocdn.net/s107/5fe81d48e05fc40b/public_pin_l/2317048272.jpg")!,
            title: "Concurrency"
        ),
        .init(
            url: URL(string: "https://i08.fotocdn.net/s107/5fe81d48e05fc40b/public_pin_l/2317048272.jpg")!,
            title: "Animation"
        ),
        .init(
            url: URL(string: "https://i08.fotocdn.net/s107/5fe81d48e05fc40b/public_pin_l/2317048272.jpg")!,
            title: "SwiftUI"
        ),
    ]
    
    let columns: [GridItem] = (0..<2).map { _ in GridItem() }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(topics) { topic in
                        TopicView(topic: topic)
                    }
                }
                .padding()
            }
            .navigationTitle("Topics")
        }
    }
}
struct TopicsView_Previews: PreviewProvider {
    static var previews: some View {
        TopicsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
