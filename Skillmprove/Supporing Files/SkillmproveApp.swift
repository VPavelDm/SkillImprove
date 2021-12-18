//
//  SkillmproveApp.swift
//  Skillmprove
//
//  Created by Pavel Vaitsikhouski on 14.12.21.
//

import SwiftUI

@main
struct SkillmproveApp: App {
    var body: some Scene {
        WindowGroup {
            #warning("Make main context")
            QuizGameView(context: PersistenceController.preview.mainContext, search: QuizGameSearch())
                .preferredColorScheme(.dark)
                .onAppear {
                    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
                }
        }
    }
}
