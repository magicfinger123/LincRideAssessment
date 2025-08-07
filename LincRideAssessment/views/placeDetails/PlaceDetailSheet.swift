//
//  PlaceDetailSheet.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//

import SwiftUI
import MapKit


struct PlaceDetailSheet: View {
    let place: Place
    @State private var isSaved: Bool = false
    private let realmManager = RealmManager()
    @State private var saveBtnText = "Add to favorites"
    @State private var lookAroundScene: MKLookAroundScene?
    
    @Environment(\.dismiss) private var dismiss  // ← Access to dismiss action

    var body: some View {
        VStack(spacing: 16) {
            // Drag Handle
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 40, height: 5)
                .foregroundColor(.gray.opacity(0.4))
                .padding(.top, 8)

            // Dismiss Button (top-left)
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal)

            // Place Name
            Text(place.name)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)

            // Address
            Text(place.address)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            // Category
            Text(place.category)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Divider()

            // Static Map Preview
            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: place.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                )
            ))
            .frame(height: 150)
            .cornerRadius(10)
            .padding(.horizontal)

            // Look Around Preview
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.vertical)
            } else {
                ContentUnavailableView(
                    "No preview available for this place",
                    systemImage: "eye.slash"
                )
            }

            // Save Button
            Button(action: {
                realmManager.saveFavorite(place: place)
                isSaved = true
            }) {
                Label(saveBtnText, systemImage: "heart.fill")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isSaved ? Color.blue.opacity(0.2) : Color.blue.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(isSaved)

            Spacer()
        }
        .padding()
        .onAppear {
            isSaved = realmManager.isFavorite(place.id.uuidString)
            fetchLookAroundPreview()
        }
        .onChange(of: isSaved) { _, newValue in
            saveBtnText = newValue ? "Already saved in favorites" : "Add to favorites"
        }
        .presentationDetents([.large])
    }

    private func fetchLookAroundPreview() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(coordinate: place.coordinate)
            lookAroundScene = try? await request.scene
        }
    }
}
