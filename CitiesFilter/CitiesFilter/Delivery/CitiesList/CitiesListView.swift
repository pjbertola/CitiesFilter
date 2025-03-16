//
//  CitiesListView.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import SwiftUI

struct CitiesListView: View {
    @State var cities: [CityModel] = []
    @State private var visibility: NavigationSplitViewVisibility = .all
    var repository: CitiesRepository

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List {
                ForEach(cities, id: \.id) { city in
                    NavigationLink {
                        CityMapView(city: city)
                    } label: {
                        CityRow(city: city)
                    }
                }
            }
            .navigationTitle("Cities")
        } detail: {
                Text("Select a City")
        }
        .navigationSplitViewStyle(.balanced)
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
