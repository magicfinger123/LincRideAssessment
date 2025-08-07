//
//  Place.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 05/08/2025.
//


import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let coordinate: CLLocationCoordinate2D
    let address: String
 
}
