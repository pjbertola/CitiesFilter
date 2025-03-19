//
//  CityMocks.swift
//  CitiesFilterTests
//
//  Created by Pablo J. Bertola on 18/03/2025.
//

import Foundation
@testable import CitiesFilter

class CityMocks {
    func getCities() -> [CityModel] {
        return [
            CityModel(name: "Alabama", country: "US", id: 1, latitude: 0.0, longitude: 0.0),
            CityModel(name: "Albuquerque", country: "US", id: 2, latitude: 0.0, longitude: 0.0),
            CityModel(name: "Anaheim", country: "US", id: 2, latitude: 0.0, longitude: 0.0),
            CityModel(name: "Arizona", country: "US", id: 2, latitude: 0.0, longitude: 0.0),
            CityModel(name: "Sydney", country: "AU", id: 2, latitude: 0.0, longitude: 0.0),
            
        ]
    }
}
