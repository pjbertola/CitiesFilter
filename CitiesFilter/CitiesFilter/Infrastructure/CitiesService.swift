//
//  CitiesService.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation

protocol CitiesService {
    func getCities() async throws -> [CityData]
}

class CitiesServiceDefault: CitiesService {
    func getCities() async throws -> [CityData] {
        var cities: [CityData] = []
        if let url = CitiesEndpoint().asURL {
            let urlRequest = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            cities = try decoder.decode([CityData].self, from: data)
        }
        return cities
    }
}

struct CitiesEndpoint {
    private let path: String = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"

    var asURL: URL? {
        URL(string: path)
    }
}
