//
//  RealSearchService.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 07/08/2025.
//


import MapKit

class RealSearchService: SearchService {
    func searchNearby(for category: String, in region: MKCoordinateRegion, completion: @escaping ([Place], String?) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = category
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                completion([], "Search failed: \(error.localizedDescription)")
                return
            }

            guard let items = response?.mapItems, !items.isEmpty else {
                completion([], "No results found for '\(category)'")
                return
            }

            let places = items.map {
                Place(name: $0.name ?? "Unknown",
                      category: category,
                      coordinate: $0.placemark.coordinate,
                      address: $0.placemark.title ?? "")
            }

            completion(places, nil)
        }
    }

    func searchPlace(named name: String, completion: @escaping (Place?, String?) -> Void) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                completion(nil, "Search failed: \(error.localizedDescription)")
                return
            }

            guard let item = response?.mapItems.first else {
                completion(nil, "Place not found.")
                return
            }

            let place = Place(name: item.name ?? "Unknown",
                              category: item.pointOfInterestCategory?.rawValue ?? "",
                              coordinate: item.placemark.coordinate,
                              address: item.placemark.title ?? "")

            completion(place, nil)
        }
    }
}
