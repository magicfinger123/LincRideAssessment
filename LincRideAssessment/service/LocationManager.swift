//
//  LocationManager.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 05/08/2025.
//


import Foundation
import MapKit
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var lastLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var permissionDenied = false
    @Published var errorMessage: String?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    var locationServicesEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    func requestLocation() {
        if locationServicesEnabled {
            manager.requestLocation()
        } else {
            errorMessage = "Location services are disabled"
        }
    }
    
    func requestLocationPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if manager.authorizationStatus == .denied {
            permissionDenied = true
            errorMessage = "Location access is denied"
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            case .denied, .restricted:
                self.permissionDenied = true
                self.errorMessage = "Location access is denied or restricted"
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            @unknown default:
                self.errorMessage = "Unknown authorization status"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed: \(status.rawValue)")
        DispatchQueue.main.async {
            self.authorizationStatus = status
            
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            case .denied, .restricted:
                self.permissionDenied = true
                self.errorMessage = "Location access is denied or restricted"
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            @unknown default:
                self.errorMessage = "Unknown authorization status"
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.location = location
            self.lastLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
}

