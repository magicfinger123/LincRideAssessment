//
//  SearchBarView.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 06/08/2025.
//


import SwiftUI

struct SearchBarView: View {
    @Binding var query: String
    @ObservedObject var completerVM: SearchCompleterViewModel
    var onSuggestionTapped: (String) -> Void

    var body: some View {
        VStack(spacing: 8) {
            SearchField(query: $query, onClear: clearSearch)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )

            if !completerVM.suggestions.isEmpty {
                SuggestionsList(suggestions: completerVM.suggestions) { suggestion in
                    onSuggestionTapped(suggestion.title)
                    clearSearch()
                }
            }
        }
        .padding(.horizontal)
        .onChange(of: query) { _, newValue in
            completerVM.updateQuery(newValue)
        }
    }

    private func clearSearch() {
        query = ""
        completerVM.suggestions = []
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
