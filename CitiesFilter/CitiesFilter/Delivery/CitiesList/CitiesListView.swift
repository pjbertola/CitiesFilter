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
    @State private var showFavoritesOnly = false
    var filteredCities: [CityModel] {
        cities.filter { city in
            (!showFavoritesOnly || city.isFavorite)
        }
    }
    var repository: CitiesRepository

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            List {
                Group {
                    Toggle(isOn: $showFavoritesOnly) {
                        Text("Favorites only")
                            .bold()
                    }
                }
                ForEach(filteredCities, id: \.id) { city in
                    NavigationLink {
                        CityMapView(city: city)
                    } label: {
                        CityRow(repository: repository).environment(city)
                    }
                }
            }
            .navigationTitle("Cities")
        } detail: {
                Text("Select a City")
        }
        .navigationSplitViewStyle(.balanced)
        .task {
            let unsortedCities = await repository
                .getCities()
            cities = unsortedCities.sorted { $0.nameTitle < $1.nameTitle }
            print("cities: " + String(cities.count))
        }
    }
}

#Preview {
    CitiesListView(repository: CitiesRepositoryBuilder().getRepository())
}
