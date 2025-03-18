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
        CitiesRepositoryDefault(citiesService: CitiesServiceDefault(), databaseManager: DatabaseManagerDefault())
    }
}
