//
//  CitiesService.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation

enum CitiesServiceApiClient {
    case live
    case mock
}
protocol CitiesService {
    func getCities() async throws -> [CityData]
}

class CitiesServiceDefault: CitiesService {
    private let apiClient: CitiesServiceApiClient

    init(apiClient: CitiesServiceApiClient = .live) {
        self.apiClient = apiClient
    }

    func getCities() async throws -> [CityData] {
        var cities: [CityData] = []
        if let url = getURL() {
            let urlRequest = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            cities = try decoder.decode([CityData].self, from: data)
        }
        return cities
    }

    private func getURL() -> URL? {
        switch apiClient {
        case .live:
            return CitiesEndpoint().asURL
        case .mock:
            return CitiesMockEndpoint().asURL
        }
    }
}

struct CitiesEndpoint {
    private let path: String = "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json"

    var asURL: URL? {
        URL(string: path)
    }
}

struct CitiesMockEndpoint {
    private let path: String = "cities.json"
    var asURL: URL? {
        guard let file = Bundle.main.url(forResource: path, withExtension: nil)
        else {
            fatalError("Couldn't find \(path) in main bundle.")
        }
        return file
    }
}
