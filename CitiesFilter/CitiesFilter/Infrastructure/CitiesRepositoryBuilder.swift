//
//  CitiesRepositoryBuilder.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 17/03/2025.
//

import Foundation
import SwiftUI
import SwiftData

class CitiesRepositoryBuilder {
    @MainActor func getRepository() -> CitiesRepository {
        var databaseManager: DatabaseManager = DatabaseManagerDefault()
        // Use Mock if ui testing
        if isUITestingEnabled() {
            databaseManager = DatabaseManagerMock()
        }
        
        return CitiesRepositoryDefault(citiesService: CitiesServiceDefault(), databaseManager: databaseManager)
    }

    private func isUITestingEnabled() -> Bool {
        ProcessInfo.processInfo.environment["UI_Testing_Enabled"] == "true"
    }
}
