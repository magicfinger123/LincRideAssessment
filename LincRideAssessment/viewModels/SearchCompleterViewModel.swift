//
//  SearchCompleterViewModel.swift
//  LincRideAssessment
//
//  Created by Michael Ossai on 05/08/2025.
//


import Foundation
import MapKit
import Combine

class SearchCompleterViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    private var completer: MKLocalSearchCompleter

    @Published var suggestions: [MKLocalSearchCompletion] = []

    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()
        self.completer.delegate = self
    }

    func updateQuery(_ query: String) {
        completer.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        suggestions = Array(completer.results.prefix(10))
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Autocomplete error: \(error.localizedDescription)")
    }
}
