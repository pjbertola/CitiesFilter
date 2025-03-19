//
//  FilterModule.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 18/03/2025.
//

import Foundation

protocol FilterModule {
    func setup(with cities: [CityModel])
    func filter(text: String, hasToBeFavorite: Bool) -> [CityModel]
    func updateFavoriteStatus(for city: CityModel)
}

class FilterModuleDefault: FilterModule {
    private var dictionaryKeys: [String: Set<String>] = [:]
    private var allCities: [CityModel] = []
    private var allCitiesDic: [String: CityModel] = [:]
    private var favoritesSet: Set<String> = []
    private let maxKeyLength: Int = 2

    func setup(with cities: [CityModel]) {
        self.allCities = cities
        
        cities.forEach {
            // build a Dictionary with all the cities
            allCitiesDic[getCityKey(city: $0)] = $0
            
            //build a set for the favorites
            if $0.isFavorite {
                favoritesSet.insert(getCityKey(city: $0))
            }
            // Build dictionary Key
            addToDictionaryKey(city: $0)
        }
    }

    func filter(text: String, hasToBeFavorite: Bool) -> [CityModel] {
        let searcherText = text.lowercased()
        let prefix = String(searcherText.prefix(maxKeyLength))
        
        // If the text is empty, we simplify the search.
        guard !prefix.isEmpty else {
            return filterWithEmptyPrefix(hasToBeFavorite: hasToBeFavorite)
        }
        // filter with text.
        let filteredCities = filterWith(prefix: prefix,
                                        searcherText: searcherText,
                                        hasToBeFavorite: hasToBeFavorite)
        // return filtered cities
        return filteredCities.sorted { $0.nameTitle < $1.nameTitle }
    }

    func updateFavoriteStatus(for city: CityModel) {
        if city.isFavorite {
            favoritesSet.insert(getCityKey(city: city))
        } else {
            favoritesSet.remove(getCityKey(city: city))
        }

    }
}

private extension FilterModuleDefault {
    
    /// Build a key use in the sets and the dictionary
    /// - Parameter city: city
    /// - Returns: the city's key
    func getCityKey(city: CityModel) -> String {
        return city.nameTitle + "__" + String(city.id)
    }
    
    /// Add the city key to a dictionary keys of set with two entrance. One with the first letter of the name and de other with the two first
    /// - Parameter city: the city to add
    func addToDictionaryKey(city: CityModel) {
        let first = city.nameTitle.prefix(1).lowercased()
        let firstTwo = city.nameTitle.prefix(maxKeyLength).lowercased()
        if dictionaryKeys[first] == nil {
            dictionaryKeys[first] = []
        }
        if dictionaryKeys[firstTwo] == nil {
            dictionaryKeys[firstTwo] = []
        }
        dictionaryKeys[first]?.insert(getCityKey(city: city))
        dictionaryKeys[firstTwo]?.insert(getCityKey(city: city))
    }
    
    /// Simplify the search if the search if with no text. Returning all the cities or only the favorites.
    /// - Parameter hasToBeFavorite: if it has to be favorite
    /// - Returns: filtered cities
    func filterWithEmptyPrefix(hasToBeFavorite: Bool) -> [CityModel] {
        if !hasToBeFavorite {
            return allCities
        } else {
            return favoritesSet.compactMap {
                allCitiesDic[$0]
            }.sorted { $0.nameTitle < $1.nameTitle }
        }
    }
    
    /// Search in the dictonary of set the keys of the cities with that prefix and check if meet the conditions.
    /// - Parameters:
    ///   - prefix: key to the dictionary of sets
    ///   - searcherText: input of the user to search
    ///   - hasToBeFavorite: if favorite is needed
    /// - Returns: filtered cities
    func filterWith(prefix: String, searcherText: String, hasToBeFavorite: Bool) -> [CityModel] {
        return dictionaryKeys[prefix]?.compactMap {
            if let city = allCitiesDic[$0], city.nameTitle.lowercased().hasPrefix(searcherText), (!hasToBeFavorite || city.isFavorite) {
                return city
            }
            return nil
        } ?? []
    }
}
