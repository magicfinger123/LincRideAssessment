//
//  SavedPlaceMapView.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 07/08/2025.
//


import SwiftUI
import MapKit


struct SavedPlaceMapView: View {
    let place: Place
    @State private var cameraPosition: MapCameraPosition
    @Environment(\.dismiss) private var dismiss

    init(place: Place) {
        self.place = place
        _cameraPosition = State(initialValue: .region(
            MKCoordinateRegion(
                center: place.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ))
    }

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                Annotation(place.name, coordinate: place.coordinate) {
                    VStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                        Text(place.name)
                            .font(.caption)
                            .fixedSize()
                    }
                }
            }
            .ignoresSafeArea()

            VStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 40, height: 5)
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.top, 8)

                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }

                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
}
