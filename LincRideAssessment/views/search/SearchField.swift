//
//  SearchField.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//


import SwiftUI

struct SearchField: View {
    @Binding var query: String
    var onClear: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search for places", text: $query)
                .foregroundColor(.primary)

            if !query.isEmpty {
                Button(action: onClear) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
