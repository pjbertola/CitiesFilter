//
//  CitiesListBuilder.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import Foundation



class CitiesListBuilder {
    @MainActor func getView() -> CitiesListView {
        CitiesListView(viewModel: CitiesListViewModelBuilder().getViewModel())
    }
}
