//
//  CitiesFilterUITests.swift
//  CitiesFilterUITests
//
//  Created by Pablo J. Bertola on 16/03/2025.
//

import XCTest

final class CitiesFilterUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testFavorite() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchEnvironment["UI_Testing_Enabled"] = "true"
        app.launch()

        let cityList = app.collectionViews["CitiesList"]
        //Alabama Cell -> press favorite
        cityList.cells.element(boundBy: 1).buttons["Toggle Favorite"].tap()
        print("pjb cityList.cells: " + String(cityList.cells.count))

        // Press Favorite only
        let toggledFavoriteCell = cityList.cells.element(boundBy: 0)
        let switchFav = toggledFavoriteCell.switches["Favorite only"]
        switchFav.tap()
        
        // Check if only shows Alabama and Favorite toggle
        XCTAssertTrue(cityList.cells.count == 2)
        
        //Alabama Cell -> press favorite again.
        cityList.cells.element(boundBy: 1).buttons["Toggle Favorite"].tap()
        print("pjb cityList.cells: " + String(cityList.cells.count))

        // Now only has to shows Favorite toggle
        XCTAssertTrue(cityList.cells.count == 1)
    }

    @MainActor
    func testGoToMapView() throws {
        let app = XCUIApplication()
        app.launchEnvironment["UI_Testing_Enabled"] = "true"
        app.launch()

        //Alabama Cell
        let cell = app.collectionViews.children(matching: .cell).element(boundBy: 1)
        cell.tap()
        XCTAssertTrue(app.otherElements["Alabama, US"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.maps.element.waitForExistence(timeout: 3))
    }
    func testFilter() throws {
        let app = XCUIApplication()
        app.launchEnvironment["UI_Testing_Enabled"] = "true"
        app.launch()
        let cityList = app.collectionViews["CitiesList"]

        // Check if there are 5 cities and favorite toggle
        XCTAssertTrue(cityList.cells.count == 6)

        // Filter by "al"
        let citiesNavigationBar = XCUIApplication().navigationBars["Cities"]
        let searchSearchField = citiesNavigationBar.searchFields["Search"]
        searchSearchField.tap()
        searchSearchField.typeText("al")

        // Check if there are 2 cities and favorite toggle
        XCTAssertTrue(cityList.cells.count == 3)

        // Clear the search
        searchSearchField.buttons["Clear text"].tap()

        // Check if there are avery city
        XCTAssertTrue(cityList.cells.count == 6)
    }
}

