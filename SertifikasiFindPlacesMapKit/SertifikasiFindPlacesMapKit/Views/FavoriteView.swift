//
//  FavoriteView.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 23/02/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager

    var body: some View {
        NavigationStack {
            List {
                if favoritesManager.favoritePlaces.isEmpty {
                    Text("No favorite places yet.")
                        .foregroundColor(.gray)
                        .italic()
                } else {
                    ForEach(favoritesManager.favoritePlaces) { place in
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
            .navigationTitle("Favorites")
        }
    }
}
