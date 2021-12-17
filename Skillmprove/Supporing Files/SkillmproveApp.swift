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
            QuizGameView(QuizGameSearch())
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
                .preferredColorScheme(.dark)
                .onAppear {
                    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
                }
        }
    }
}
