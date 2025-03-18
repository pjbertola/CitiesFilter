//
//  FavoriteButton.swift
//  CitiesFilter
//
//  Created by Pablo J. Bertola on 17/03/2025.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    var repository: CitiesRepository
    var body: some View {
        Button {
            isSet.toggle()
            print("Toggle " + String(isSet))
            repository.saveContext()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .yellow : .gray)
                .frame(width: 30, height: 30)
        }
        .buttonStyle(.plain)

    }
}

#Preview {
    FavoriteButton(isSet: .constant(true), repository: CitiesRepositoryBuilder().getRepository())
}
