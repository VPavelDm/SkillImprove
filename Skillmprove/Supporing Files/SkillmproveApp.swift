//
//  SkillmproveApp.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import SwiftUI

@main
struct SkillmproveApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TopicsView()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
