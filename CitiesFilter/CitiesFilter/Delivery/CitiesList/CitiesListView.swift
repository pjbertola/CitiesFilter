//
//  CitiesListView.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import SwiftUI

struct CitiesListView: View {
    @State var cities: [CityModel] = []

    var repository: CitiesRepository
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(cities) { city in
                    NavigationLink {
                        CityMapView(city: city)
                    } label: {
                        CityRow(city: city)
                    }
                    .listStyle(.sidebar)
                }
            }
            .menuIndicator(.hidden)
        } detail:  {
            Text("Select a City")
        }
        .task {
            cities = await CitiesRepositoryDefault()
                .getCities()
            print(cities.count)

        }
    }
}

#Preview {
    CitiesListView(repository: CitiesRepositoryDefault())
}
