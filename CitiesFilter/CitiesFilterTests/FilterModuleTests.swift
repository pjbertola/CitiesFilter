//
//  FilterModuleTests.swift
//  CitiesFilterTests
//
//  Created by Pablo J. Bertola on 18/03/2025.
//

import XCTest
@testable import CitiesFilter

final class FilterModuleTests: XCTestCase {
    var filterModule: FilterModule!
    var cities: [CityModel]!

    override func setUp() {
        //Given
        givenFilterModule()
        givenCities()
        filterModule.setup(with: cities)
    }
    func test_Filter_A() throws {
        //When
        let filteredCities = filterModule.filter(text: "A", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 4)
        let sotedCities = filteredCities.sorted { $0.nameTitle < $1.nameTitle }
        XCTAssertEqual(filteredCities, sotedCities)
    }
    func test_Filter_a() throws {
        //When
        let filteredCities = filterModule.filter(text: "a", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 4)
        let sotedCities = filteredCities.sorted { $0.nameTitle < $1.nameTitle }
        XCTAssertEqual(filteredCities, sotedCities)

    }
    func test_Filter_S() throws {
        //When
        let filteredCities = filterModule.filter(text: "S", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 1)
    }
    func test_Filter_aL() throws {
        //When
        let filteredCities = filterModule.filter(text: "aL", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 2)
        XCTAssertTrue(filteredCities[0].nameTitle < filteredCities[1].nameTitle)
    }
    func test_Filter_x() throws {
        //When
        let filteredCities = filterModule.filter(text: "x", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 0)
    }
    func test_Filter_LongString() throws {
        //When
        let filteredCities = filterModule.filter(text: "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 0)
    }
    func test_Filter_Albuquerque() throws {
        //When
        let filteredCities = filterModule.filter(text: "Albuquerque", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 1)
    }
    func test_Filter_favorites_empty() throws {
        //When
        let filteredCities = filterModule.filter(text: "aL", hasToBeFavorite: true)
        //Then
        XCTAssertEqual(filteredCities.count, 0)
    }
    func test_Filter_favorite_first() throws {
        //Given
        cities[0].isFavorite = true
        filterModule.setup(with: cities)
        //When
        let filteredCities = filterModule.filter(text: "aL", hasToBeFavorite: true)
        //Then
        XCTAssertEqual(filteredCities.count, 1)
    }
    func test_Filter_favorite_emptyText() throws {
        //Given
        cities[0].isFavorite = true
        cities[1].isFavorite = true
        filterModule.setup(with: cities)
        //When
        let filteredCities = filterModule.filter(text: "", hasToBeFavorite: true)
        //Then
        XCTAssertEqual(filteredCities.count, 2)
        XCTAssertTrue(filteredCities[0].nameTitle < filteredCities[1].nameTitle)
    }
    func test_Filter_no_favorite_emptyText() throws {
        //Given
        cities[0].isFavorite = true
        filterModule.setup(with: cities)
        //When
        let filteredCities = filterModule.filter(text: "", hasToBeFavorite: false)
        //Then
        XCTAssertEqual(filteredCities.count, 5)
        let sotedCities = filteredCities.sorted { $0.nameTitle < $1.nameTitle }
        XCTAssertEqual(filteredCities, sotedCities)

    }
}

extension FilterModuleTests {
    func givenFilterModule() {
        filterModule = FilterModuleDefault()
    }
    func givenCities() {
        cities = CityMocks().getCities()
    }
}
