//
//  SearchService.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 07/08/2025.
//

import MapKit

protocol SearchService {
    func searchNearby(for category: String, in region: MKCoordinateRegion, completion: @escaping ([Place], String?) -> Void)
    func searchPlace(named name: String, completion: @escaping (Place?, String?) -> Void)
}
