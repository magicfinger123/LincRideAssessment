//
//  SavedPlacesViewModelTests.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 07/08/2025.
//

import MapKit
import XCTest
@testable import LincRideAssessment

final class SavedPlacesViewModelTests: XCTestCase {

    var mockRealm: MockRealmManager!
    var viewModel: SavedPlacesViewModel!

    override func setUp() {
        super.setUp()
        mockRealm = MockRealmManager()
        
        // Add mock data
        let place = FavoritePlace(
            id: "test-id",
            name: "Test Place",
            address: "123 Test St", category: "Cafe",
            coordinate: CLLocationCoordinate2D(latitude: 1.0, longitude: 1.0)
        )
        mockRealm.addMockFavorite(place)

        viewModel = SavedPlacesViewModel(realmManager: mockRealm)
    }

    func testLoadFavorites() {
        XCTAssertEqual(viewModel.favorites.count, 1)
        XCTAssertEqual(viewModel.favorites.first?.name, "Test Place")
    }

    func testDeleteFavorite() {
        XCTAssertEqual(viewModel.favorites.count, 1)

        viewModel.deleteFavorite(at: IndexSet(integer: 0))

        XCTAssertEqual(viewModel.favorites.count, 0)
    }
}
