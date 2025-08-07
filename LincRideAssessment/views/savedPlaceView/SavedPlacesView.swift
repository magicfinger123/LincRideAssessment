import SwiftUI


struct SavedPlacesView: View {
    @StateObject private var viewModel = SavedPlacesViewModel()
    @State private var selectedPlace: Place?
    @State private var showMap = false

    var body: some View {
        NavigationView {
            Group {
                if viewModel.favorites.isEmpty {
                    VStack {
                        Spacer()
                        Text("No places have been saved")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                } else {
                    List {
                        ForEach(viewModel.favorites) { place in
                            Button {
                                selectedPlace = Place(
                                    name: place.name,
                                    category: place.category,
                                    coordinate: place.coordinate,
                                    address: place.address
                                )
                                showMap = true
                            } label: {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(place.name)
                                        .font(.headline)
                                    Text(place.address)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onDelete(perform: viewModel.deleteFavorite)
                    }
                }
            }
            .navigationTitle("Saved Places")
            .toolbar {
                EditButton()
            }
            .sheet(isPresented: $showMap) {
                if let place = selectedPlace {
                    SavedPlaceMapView(place: place)
                }
            }
        }
    }
}
