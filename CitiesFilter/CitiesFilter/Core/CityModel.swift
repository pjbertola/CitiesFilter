//
//  CityModel.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation

class CityModel {
    let nameTitle: String
    let id: Int
    let coordinate: CoordinateModel
    var coordinateDescription: String {
        "Latitude: " + coordinate.latitude.description + " - Longitude:" + coordinate.longitude.description
    }
    init(name: String, country: String, id: Int, coordinate: CoordinateModel) {
        self.nameTitle = name + ", " + country
        self.id = id
        self.coordinate = coordinate

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
