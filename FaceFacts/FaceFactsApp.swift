//
//  FaceFactsApp.swift
//  FaceFacts
//
//  Created by Javal Nanda on 22/12/23.
//

import SwiftData
import SwiftUI

@main
struct FaceFactsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Person.self)
    }
}
