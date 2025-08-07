//
//  MapViewSection.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//


import SwiftUI
import MapKit

struct MapViewSection: View {
    @ObservedObject var viewModel: MapViewModel
    @ObservedObject var locationManager: LocationManager

    // Start with viewModel.region so it reflects the initial region of the view model
    @State private var cameraPosition: MapCameraPosition

    init(viewModel: MapViewModel, locationManager: LocationManager) {
        self.viewModel = viewModel
        self.locationManager = locationManager
        // Initialize cameraPosition from viewModel.region
        _cameraPosition = State(initialValue: .region(viewModel.region))
    }

    var body: some View {
        Map(position: $cameraPosition) {
            if let currentLocation = locationManager.location?.coordinate {
                       Annotation("My Location", coordinate: currentLocation) {
                           Image(systemName: "location.fill")
                               .resizable()
                               .frame(width: 20, height: 20)
                               .foregroundStyle(.blue)
                               .background(Circle().fill(Color.white).frame(width: 30, height: 30))
                       }
                   }

            ForEach(viewModel.places) { place in
                Annotation(place.name, coordinate: place.coordinate) {
                    Button {
                        viewModel.selectedPlace = place
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
            }
        }
        .mapControls {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        .onAppear {
            locationManager.requestLocation()
            // If location is already available, update cameraPosition
            if let loc = locationManager.location {
                viewModel.updateRegion(to: loc.coordinate)
                cameraPosition = .region(viewModel.region)
            }
        }
        .onChange(of: locationManager.location) { _, loc in
            if let loc = loc {
                viewModel.updateRegion(to: loc.coordinate)
                cameraPosition = .region(viewModel.region)
            }
        }
        .onChange(of: viewModel.region) { _,newRegion in
            // Optional: keep cameraPosition in sync if region changes elsewhere
            cameraPosition = .region(newRegion)
        }
    }
}



extension CLLocationCoordinate2D {
    /// Default coordinate fallback (e.g., Miami)
    static let defaultUserLocation = CLLocationCoordinate2D(latitude: 25.7602, longitude: -80.1959)
}

extension MKCoordinateRegion {
    /// Default region centered on default user location with 10km span
    static var defaultUserRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: .defaultUserLocation,
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000
        )
    }
}

extension MKCoordinateRegion: @retroactive Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude &&
        lhs.center.longitude == rhs.center.longitude &&
        lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
        lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
}
