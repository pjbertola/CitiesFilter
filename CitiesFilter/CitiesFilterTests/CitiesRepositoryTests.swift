//
//  CitiesRepositoryTests.swift
//  CitiesFilterTests
//
//  Created by Pablo J. Bertola on 21/03/2025.
//

import XCTest
@testable import CitiesFilter

final class CitiesRepositoryTests: XCTestCase {
    var sut: CitiesRepository!
    var citiesService: CitiesService!
    var databaseManager: DatabaseManagerMock!

    @MainActor override func setUp() {
        givenACitiesService()
        givenADatabaseManager()
        givenACitiesRepository()
    }

    func test_fetchAll_whenCalled_returnsCities() async {
        //When
        databaseManager.fetchItemsUseMocks = false
        let cities = await sut.getCities()

        //Then
        XCTAssertEqual(cities.count, 14)
    }

    func test_databaseManagerAppend() async {
        //When
        databaseManager.fetchItemsUseMocks = false
        let cities = await sut.getCities()

        //Then
        XCTAssertTrue(databaseManager.appendCalled)
        XCTAssertEqual(databaseManager.appendItems.count, cities.count)
    }

    func test_updateData() {
        //When
        sut.saveContext()

        //Then
        XCTAssertTrue(databaseManager.saveContextCalled)
    }

    func givenACitiesService() {
        citiesService = CitiesServiceDefault(apiClient: .mock)
    }

    func givenADatabaseManager() {
        databaseManager = DatabaseManagerMock()
    }
    func givenACitiesRepository() {
        sut = CitiesRepositoryDefault(citiesService: citiesService, databaseManager: databaseManager)
    }
}
