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
    @State private var showLoading = false
    @State private var searchText: String = ""

    var filteredCities: [CityModel] {
        let tempList = viewModel.filter(text: searchText, hasToBeFavorite: showFavoritesOnly)
        return (showFavoritesOnly ? tempList.filter { city in city.isFavorite } : tempList)
    }
    var viewModel: CitiesListViewModel

    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            if showLoading {
                LoadingView()
            } else {
                List {
                    Group {
                        Toggle(isOn: $showFavoritesOnly) {
                            HStack {
                                Text("Favorite only")
                                    .bold()
                                Spacer()
                                Image(systemName: showFavoritesOnly ? "star.fill" : "star")
                            }
                        }
                        .toggleStyle(.button)
                    }
                    ForEach(filteredCities, id: \.id) { city in
                        NavigationLink {
                            CityMapView(city: city)
                        } label: {
                            CityRow(viewModel: viewModel).environment(city)
                        }
                    }
                }
                .navigationTitle("Cities")
                .searchable(text: $searchText)
                .animation(.default, value: filteredCities)
                .accessibilityIdentifier("CitiesList")
            }
            
        } detail: {
            if showLoading {
                LoadingView(showProgress: false)
            } else {
                Text("Select a City")
            }
        }
        .navigationSplitViewStyle(.balanced)
        .task {
            showLoading = true
            cities = await viewModel
                .getCities()
            cities.sort { $0.nameTitle < $1.nameTitle }
            print("cities: " + String(cities.count))
            showLoading = false
        }
    }
}

#Preview {
    CitiesListView(viewModel: CitiesListViewModelBuilder().getViewModel())
}
