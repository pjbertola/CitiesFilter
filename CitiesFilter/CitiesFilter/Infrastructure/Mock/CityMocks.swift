//
//  CityMocks.swift
//  CitiesFilterTests
//
//  Created by Pablo J. Bertola on 18/03/2025.
//

import Foundation

class CityMocks {
    func getCities() -> [CityModel] {
        return [
            CityModel(name: "Alabama", country: "US", id: 4829764, latitude:32.750408 , longitude: -86.750259),
            CityModel(name: "Albuquerque", country: "US", id: 5454711, latitude: 35.084492, longitude: -106.651138),
            CityModel(name: "Anaheim", country: "US", id: 5323810, latitude: 33.835289, longitude: -117.914497),
            CityModel(name: "Arizona", country: "US", id: 5551752, latitude: 34.500301, longitude: -111.500977),
            CityModel(name: "Sydney", country: "AU", id: 2147714, latitude: -33.867851, longitude: 151.207321)
        ]
    }
}
