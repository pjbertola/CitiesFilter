//
//  CityRow.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import SwiftUI

struct CityRow: View {
    @Environment(CityModel.self) var city

    var body: some View {
        @Bindable var city = city
        HStack {
            VStack(alignment: .leading) {
                Text(city.nameTitle)
                    .font(.title)
                Text(city.coordinateDescription)
                    .font(.subheadline)
            }
            .padding(1)
            Spacer()
            HStack {
                Menu {
                    Text("Info: " + city.nameTitle)
                } label: {
                    Image(systemName: "ellipsis")
                        .frame(width: 30, height: 30)
                }
                FavoriteButton(isSet: $city.isFavorite)

            }
            .padding(1)
        }
    }
}

#Preview {
    let city = CityModel(name: "Madrid", country: "ES", id: 1, coordinate: .init(longitude: 40.416775, latitude: -3.703790))
    CityRow().environment(city)
}
