//
//  MapViewModel.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 05/08/2025.
//


import Foundation
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion.defaultUserRegion
    @Published var places: [Place] = []
    @Published var selectedPlace: Place?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let searchService: SearchService

    init(searchService: SearchService = RealSearchService()) {
        self.searchService = searchService
    }

    func updateRegion(to coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }

    func setError(_ message: String) {
        self.errorMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.errorMessage = nil
        }
    }

    func searchNearby(for category: String) {
        isLoading = true
        errorMessage = nil

        searchService.searchNearby(for: category, in: region) { [weak self] places, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.setError(error)
                    self?.places = []
                } else {
                    if places.isEmpty {
                        self?.setError("No nearby place found")
                        self?.places = []
                    }
                    self?.places = places
                }
            }
        }
    }

    func searchPlace(named name: String) {
        isLoading = true
        errorMessage = nil

        searchService.searchPlace(named: name) { [weak self] place, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.setError(error)
                    return
                }
                if let place = place {
                    self?.updateRegion(to: place.coordinate)
                    self?.places = [place]
                }
            }
        }
    }
}
