//
//  CityRow.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import SwiftUI

struct CityRow: View {
    var city: CityModel
    var body: some View {
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
                }

                Button("", systemImage: "star") {
                    
                }
            }
            .padding(1)
        }
    }
}

#Preview {
    let city: CityModel = .init(name: "Madrid", country: "ES", id: 1, coordinate: .init(longitude: 40.416775, latitude: -3.703790))
    CityRow(city: city)
}
