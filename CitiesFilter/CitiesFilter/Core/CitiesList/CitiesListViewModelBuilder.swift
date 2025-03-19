//
//  CitiesListViewModelBuilder.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 19/03/2025.
//

import Foundation

class CitiesListViewModelBuilder {
    @MainActor func getViewModel() -> CitiesListViewModel {
        CitiesListViewModelDefault(repository: CitiesRepositoryBuilder().getRepository(),
                                   filter: FilterModuleDefault())
    }
}
