//
//  CitiesRepository.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation

protocol CitiesRepository {
    func getCities() async -> [CityModel]
}

class CitiesRepositoryDefault: CitiesRepository {
    private let citiesService: CitiesService
    private var cities: [CityModel] = []

    init(citiesService: CitiesService = CitiesServiceDefault()) {
        self.citiesService = citiesService
    }

    func getCities() async -> [CityModel] {
        guard cities.isEmpty else {
            return cities
        }

        do {
            let citiesData = try await citiesService.getCities()
            cities = citiesData.map { $0.toModel() }
        } catch {
            print("error")
        }

        return cities
    }
}
