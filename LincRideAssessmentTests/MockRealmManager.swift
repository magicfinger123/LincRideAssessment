//
//  MockRealmManager.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 07/08/2025.
//



import Foundation
import CoreLocation
@testable import LincRideAssessment

class MockRealmManager: RealmManager {
    private var favorites: [FavoritePlace] = []

    override func getFavorites() -> [FavoritePlace] {
        return favorites
    }

    override func deleteFavorite(with id: String) {
        favorites.removeAll { $0.id == id }
    }

    func addMockFavorite(_ place: FavoritePlace) {
        favorites.append(place)
    }
}
