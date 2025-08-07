//
//  RealmManager.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 05/08/2025.
//


import RealmSwift

class RealmManager {
    private var realm: Realm

    init() {
        realm = try! Realm()
    }

    func saveFavorite(place: Place) {
        let favorite = FavoritePlace(id: place.id.uuidString, name: place.name, address: place.address, category: place.category, coordinate: place.coordinate)
        try? realm.write {
            realm.add(favorite, update: .modified)
        }
    }

    func getFavorites() -> [FavoritePlace] {
        Array(realm.objects(FavoritePlace.self))
    }

    func deleteFavorite(with id: String) {
        if let object = realm.object(ofType: FavoritePlace.self, forPrimaryKey: id) {
            try? realm.write {
                realm.delete(object)
            }
        }
    }

    func isFavorite(_ id: String) -> Bool {
        realm.object(ofType: FavoritePlace.self, forPrimaryKey: id) != nil
    }
}
