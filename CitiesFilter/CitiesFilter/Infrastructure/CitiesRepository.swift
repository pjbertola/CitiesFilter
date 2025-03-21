//
//  CitiesRepository.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation
import SwiftUI
import SwiftData

protocol CitiesRepository {
    func getCities() async -> [CityModel]
    func saveContext()
}

class CitiesRepositoryDefault: CitiesRepository {
    private var cities: [CityModel] = []
    private let citiesService: CitiesService
    private let databaseManager: DatabaseManager

    init(citiesService: CitiesService,
         databaseManager: DatabaseManager) {
        self.citiesService = citiesService
        self.databaseManager = databaseManager
    }

    func getCities() async -> [CityModel] {
        cities = await getCitiesLocally()

        guard cities.isEmpty else {
            print("cities from disc")
            return cities
        }

        do {
            let citiesData = try await citiesService.getCities()
            cities = citiesData.map { $0.toModel() }
            let result = await self.databaseManager.append(items: cities)
            print("databaseManager.append")
            print(result)
        } catch {
            print("error")
        }

        return cities
    }
    func saveContext() {
        databaseManager.saveContext()
    }
    private func getCitiesLocally() async -> [CityModel] {
        let result: Result<[CityModel], Error> = await databaseManager.fetchItems()

        switch result {
        case .success(let cities):
            print("getCitiesLocally: " + String(describing: cities.count))
            return cities
        case .failure(let error):
            print("Error fetching cities: \(error)")
            return []
        }
    }
}
