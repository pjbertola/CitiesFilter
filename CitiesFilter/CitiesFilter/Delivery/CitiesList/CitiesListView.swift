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
    @State var showLoading = false
    var filteredCities: [CityModel] {
        let tempList = viewModel.filter(text: "", hasToBeFavorite: showFavoritesOnly)
        return tempList.filter { city in
            (!showFavoritesOnly || city.isFavorite)
        }
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
                            Text("Favorites only")
                                .bold()
                        }
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
