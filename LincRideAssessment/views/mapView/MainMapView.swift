//
//  MainMapView.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 05/08/2025.
//

import SwiftUI
import MapKit


struct MainMapView: View {
    @StateObject private var viewModel = MapViewModel()
    @StateObject private var locationManager = LocationManager()
    @State private var searchText = ""
    @StateObject private var searchCompleterVM = SearchCompleterViewModel()

    var body: some View {
        ZStack(alignment: .top) {
            MapViewSection(viewModel: viewModel, locationManager: locationManager)
            VStack {
                SearchBarView(query: $searchText, completerVM: searchCompleterVM) { selected in
                    viewModel.searchNearby(for: selected)
                }
                Spacer()
            }
            .padding(.top, 80)
            // Loading Overlay (centered)
            if viewModel.isLoading {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    ProgressView("Searching...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(12)
                        .shadow(radius: 10)
                    Spacer()
                }
            }

            // Error Banner at Bottom
            if let errorMessage = viewModel.errorMessage {
                VStack {
                    Spacer()
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 32)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.easeInOut, value: viewModel.errorMessage)
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            PlaceDetailSheet(place: place)
        }
    }
}
