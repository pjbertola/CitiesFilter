//
//  DatabaseManagerMock.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 20/03/2025.
//

import Foundation
import SwiftData

class DatabaseManagerMock: DatabaseManager {
    var appendCalled = false
    var appendItems: [Any] = []
    func append<T>(items: [T]) async -> Result<Bool, any Error> where T : PersistentModel {
        appendCalled = true
        appendItems.append(items)
        return .success(true)
    }

    var fetchItemsCalled = false
    func fetchItems<T>() async -> Result<[T], any Error> where T : PersistentModel {
        fetchItemsCalled = true
        return .success(CityMocks().getCities() as! [T])
    }

    var saveContextCalled = false
    func saveContext() {
        saveContextCalled = true
    }
}
