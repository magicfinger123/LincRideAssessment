//
//  SavedPlacesViewModel.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//

import Foundation

class SavedPlacesViewModel: ObservableObject {
    @Published var favorites: [FavoritePlace] = []

    private let realmManager: RealmManager

    init(realmManager: RealmManager = RealmManager()) {
        self.realmManager = realmManager
        loadFavorites()
    }

    func loadFavorites() {
        favorites = realmManager.getFavorites()
    }

    func deleteFavorite(at offsets: IndexSet) {
        for index in offsets {
            let place = favorites[index]
            realmManager.deleteFavorite(with: place.id)
        }
        loadFavorites()
    }
}
