//
//  SuggestionsList.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//


import SwiftUI
import MapKit

struct SuggestionsList: View {
    let suggestions: [MKLocalSearchCompletion]
    var onSelect: (MKLocalSearchCompletion) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(suggestions, id: \.self) { suggestion in
                    Button(action: {
                        onSelect(suggestion)
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.red)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(suggestion.title)
                                    .font(.subheadline)
                                    .foregroundColor(.primary)

                                if !suggestion.subtitle.isEmpty {
                                    Text(suggestion.subtitle)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }

                            Spacer()
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                    }
                    .background(Color.white)
                    .contentShape(Rectangle())
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
            )
        }
        .frame(maxHeight: 250)
        .padding(.horizontal)
    }
}
