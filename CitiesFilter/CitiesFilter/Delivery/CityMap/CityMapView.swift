//
//  CityMapView.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import SwiftUI
import MapKit

struct CityMapView: View {
    var city: CityModel
    var body: some View {
        let coordinates = CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude)
        Map() {
            Marker(city.nameTitle, coordinate: coordinates)
        }
    }
}

#Preview {
    let city: CityModel = .init(name: "Madrid", country: "ES", id: 1, latitude: -3.703790, longitude: 40.416775)
    CityMapView(city: city)
}
