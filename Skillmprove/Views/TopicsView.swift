//
//  TopicsView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import SwiftUI
import CoreData

struct TopicsView: View {    
    var body: some View {
        NavigationView {
            TopicsListView()
        }
    }
}

struct TopicsListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest
    private var topics: FetchedResults<Topic>
    
    init() {
        let request = Topic.fetchRequest(.all)
        self._topics = FetchRequest(fetchRequest: request)
    }

    let columns: [GridItem] = (0..<2).map { _ in GridItem() }
    var body: some View {
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

struct TopicsView_Previews: PreviewProvider {
    static var previews: some View {
        TopicsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
