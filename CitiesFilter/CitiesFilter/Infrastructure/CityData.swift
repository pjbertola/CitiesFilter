//
//  CityData.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation

struct CityData: Decodable {
    let country: String
    let name: String
    let id: Int
    let coordinate: CoordinateData

    enum CodingKeys: String, CodingKey {
        case country
        case name
        case id = "_id"
        case coordinate = "coord"
    }

    func toModel() -> CityModel {
        CityModel(name: name,
                  country: country,
                  id: id,
                  latitude: coordinate.latitude,
                  longitude: coordinate.longitude)
    }
}

struct CoordinateData: Decodable {
    let longitude: Double
    let latitude: Double

    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

/**
 
 {
 "country":"UA"
 ,
 "name":"Hurzuf"
 ,
 "
 _
 id":707860,
 "coord":{
 "lon":34.283333,
 "lat":44.549999
 }
 }
 */
