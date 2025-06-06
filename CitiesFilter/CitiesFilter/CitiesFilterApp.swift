//
//  CitiesFilterApp.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import SwiftUI
import SwiftData

@main
struct CitiesFilterApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CityModel.self,
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CitiesListBuilder().getView()
        }
        .modelContainer(sharedModelContainer)
    }
}
