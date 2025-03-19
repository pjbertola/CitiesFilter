//
//  CitiesListViewModel.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 19/03/2025.
//

import Foundation

protocol CitiesListViewModelUpdater {
    func updateModel(city: CityModel)
}

protocol CitiesListViewModel: CitiesListViewModelUpdater {
    func getCities() async -> [CityModel]
    func filter(text: String, hasToBeFavorite: Bool) -> [CityModel]
}

class CitiesListViewModelDefault: CitiesListViewModel {
    var repository: CitiesRepository
    var filter: FilterModule

    init(repository: CitiesRepository, filter: FilterModule) {
        self.repository = repository
        self.filter = filter
    }

    func getCities() async -> [CityModel] {
        let unsortedCities = await repository.getCities()
        let sortedCities = unsortedCities.sorted { $0.nameTitle < $1.nameTitle }
        filter.setup(with: sortedCities)
        return sortedCities
    }

    func updateModel(city: CityModel) {
        repository.saveContext()
        filter.updateFavoriteStatus(for: city)
    }

    func filter(text: String, hasToBeFavorite: Bool) -> [CityModel] {
        filter.filter(text: text, hasToBeFavorite: hasToBeFavorite)
    }
}
