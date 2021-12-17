//
//  TestCascadeApp.swift
//  TestCascade
//
//  Created by Isaak Hanimann on 17.12.21.
//

import SwiftUI

@main
struct TestCascadeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
