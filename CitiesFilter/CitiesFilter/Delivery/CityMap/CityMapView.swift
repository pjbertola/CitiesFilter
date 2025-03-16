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
        let coordinates = CLLocationCoordinate2D(latitude: city.coordinate.latitude, longitude: city.coordinate.longitude)
        Map() {
            Marker(city.nameTitle, coordinate: coordinates)
        }
    }
}

#Preview {
    let city: CityModel = .init(name: "Madrid", country: "ES", id: 1, coordinate: .init(longitude: 40.416775, latitude: -3.703790))
    CityMapView(city: city)
}
