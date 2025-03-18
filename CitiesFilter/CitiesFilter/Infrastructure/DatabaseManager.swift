//
//  DatabaseManager.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 17/03/2025.
//

import Foundation
import SwiftData

protocol DatabaseManager {
    func append<T: PersistentModel>(items: [T]) async -> Result<Bool, Error>
    func fetchItems<T: PersistentModel>() async -> Result<[T], Error>
    func saveContext()
}

final class DatabaseManagerDefault : DatabaseManager {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    init() {
        do {
            self.modelContainer = try ModelContainer(for: CityModel.self)
            self.modelContext = modelContainer.mainContext

        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }
    func append<T: PersistentModel>(items: [T]) async -> Result<Bool, Error> {
        self.modelContext.autosaveEnabled = false
        items.forEach { modelContext.insert($0) }

        do {
            try modelContext.save()
            self.modelContext.autosaveEnabled = true
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

     func fetchItems<T: PersistentModel>() async -> Result<[T], Error> {
        let fetchDescriptor = FetchDescriptor<T>()
        do {
            let items = try modelContext.fetch(fetchDescriptor)
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
    func saveContext() {
        try? modelContext.save()
    }
}
