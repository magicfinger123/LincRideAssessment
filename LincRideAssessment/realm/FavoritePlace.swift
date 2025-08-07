//
//  FavoritePlace.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 05/08/2025.
//


import Foundation
import RealmSwift
import CoreLocation

class FavoritePlace: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var address: String
    @Persisted var latitude: Double
    @Persisted var longitude: Double
    @Persisted var category: String

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    convenience init(id: String, name: String, address: String, category: String, coordinate: CLLocationCoordinate2D) {
        self.init()
        self.id = id
        self.name = name
        self.address = address
        self.category = category
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
}
