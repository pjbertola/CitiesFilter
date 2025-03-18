//
//  CityModel.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation
import SwiftData

//@Observable
@Model
final class CityModel: Identifiable {
    private(set) var nameTitle: String
    private(set) var id: Int
    private(set) var latitude: Double
    private(set) var longitude: Double
    var coordinateDescription: String {
        "Latitude: " + latitude.description + " - Longitude:" + longitude.description
    }
    var isFavorite: Bool

    init(name: String,
         country: String,
         id: Int,
         latitude: Double,
         longitude: Double,
         isFavorite: Bool = false) {
        self.nameTitle = name + ", " + country
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.isFavorite = isFavorite
    }
}
