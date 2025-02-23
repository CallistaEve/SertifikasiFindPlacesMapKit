//
//  SearchView.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 23/02/25.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject private var viewModel = LocationSearchViewModel()

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Search Results")) {
                    ForEach(viewModel.places) { place in
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
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Search Places")
            .searchable(text: $viewModel.searchQuery, prompt: "Search places...")
            .onSubmit(of: .search) {
                viewModel.searchPlaces()
            }
        }
    }
}
