//
//  TopicsView.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import SwiftUI
import CoreData

struct TopicsView: View {
    
    let columns: [GridItem] = (0..<2).map { _ in GridItem() }
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0..<10, id: \.self) { _ in
                        Text("Hello")
                    }
                }
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
