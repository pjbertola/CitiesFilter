//
//  CityModel.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation

@Observable
class CityModel: Identifiable {
    let nameTitle: String
    let id: Int
    let coordinate: CoordinateModel
    var coordinateDescription: String {
        "Latitude: " + coordinate.latitude.description + " - Longitude:" + coordinate.longitude.description
    }
    var isFavorite: Bool

    init(name: String,
         country: String,
         id: Int,
         coordinate: CoordinateModel,
         isFavorite: Bool = false) {
        self.nameTitle = name + ", " + country
        self.id = id
        self.coordinate = coordinate
        self.isFavorite = isFavorite
    }
}

class CoordinateModel {
    let longitude: Double
    let latitude: Double

    init(longitude: Double, latitude: Double) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
