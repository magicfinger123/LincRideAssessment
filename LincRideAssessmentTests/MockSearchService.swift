//
//  MockSearchService.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 07/08/2025.
//

import MapKit
@testable import LincRideAssessment

class MockSearchService: SearchService {
    var shouldFail = false

    func searchNearby(for category: String, in region: MKCoordinateRegion, completion: @escaping ([Place], String?) -> Void) {
        if shouldFail {
            completion([], "Failed to search nearby.")
        } else {
            let mockPlace = Place(name: "Test Cafe", category: "cafe", coordinate: region.center, address: "123 Main St")
            completion([mockPlace], nil)
        }
    }

    func searchPlace(named name: String, completion: @escaping (Place?, String?) -> Void) {
        if shouldFail {
            completion(nil, "Place not found.")
        } else {
            let mockPlace = Place(name: name, category: "restaurant", coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 10), address: "456 Park Ave")
            completion(mockPlace, nil)
        }
    }
}
