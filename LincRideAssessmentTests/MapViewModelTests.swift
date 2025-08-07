//
//  MapViewModelTests.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 07/08/2025.
//


import XCTest
@testable import LincRideAssessment
import CoreLocation

class MapViewModelTests: XCTestCase {
    func testUpdateRegion() {
        let vm = MapViewModel(searchService: MockSearchService())
        let coord = CLLocationCoordinate2D(latitude: 50.0, longitude: 8.0)
        vm.updateRegion(to: coord)

        XCTAssertEqual(vm.region.center.latitude, 50.0)
        XCTAssertEqual(vm.region.center.longitude, 8.0)
    }

    func testSearchNearbySuccess() {
        let mockService = MockSearchService()
        let vm = MapViewModel(searchService: mockService)

        let expectation = self.expectation(description: "SearchNearby")
        vm.searchNearby(for: "cafe")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(vm.isLoading)
            XCTAssertNil(vm.errorMessage)
            XCTAssertEqual(vm.places.count, 1)
            XCTAssertEqual(vm.places.first?.name, "Test Cafe")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSearchNearbyFailure() {
        let mockService = MockSearchService()
        mockService.shouldFail = true
        let vm = MapViewModel(searchService: mockService)

        let expectation = self.expectation(description: "SearchNearbyFail")
        vm.searchNearby(for: "museum")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(vm.isLoading)
            XCTAssertEqual(vm.places.count, 0)
            XCTAssertNotNil(vm.errorMessage)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testSearchPlaceSuccess() {
        let mockService = MockSearchService()
        let vm = MapViewModel(searchService: mockService)

        let expectation = self.expectation(description: "SearchPlace")
        vm.searchPlace(named: "Some Restaurant")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertFalse(vm.isLoading)
            XCTAssertEqual(vm.places.count, 1)
            XCTAssertEqual(vm.places.first?.name, "Some Restaurant")
            XCTAssertNil(vm.errorMessage)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
