//
//  ContentView.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 22/02/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @ObservedObject private var viewModel = LocationSearchViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // Show a map with the user's current location
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .frame(height: 250)
                    .cornerRadius(12)
                    .padding()

                List(viewModel.places) { place in
                    NavigationLink(destination: DetailView(place: place)) {
                        VStack(alignment: .leading) {
                            Text(place.name)
                                .font(.headline)
                                .bold()
                            Text(place.address)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .listStyle(.insetGrouped) // Matches iOS settings look
                .navigationTitle("Nearby Places")
                .searchable(text: $viewModel.searchQuery, prompt: "Search places...")
                .onSubmit(of: .search) {
                    viewModel.searchPlaces()
                }
            }
        }
    }
}
