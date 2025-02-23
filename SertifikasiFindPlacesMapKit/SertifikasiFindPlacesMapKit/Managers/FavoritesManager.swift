//
//  FavoritesManeger.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 23/02/25.
//
import Foundation

class FavoritesManager: ObservableObject {
    @Published var favoritePlaces: [Place] = []

    private let favoritesKey = "FavoritePlaces"

    init() {
        loadFavorites()
    }

    func addFavorite(_ place: Place) {
        if !favoritePlaces.contains(where: { $0.id == place.id }) {
            favoritePlaces.append(place)
            saveFavorites()
        }
    }

    func removeFavorite(_ place: Place) {
        favoritePlaces.removeAll { $0.id == place.id }
        saveFavorites()
    }

    func isFavorite(_ place: Place) -> Bool {
        return favoritePlaces.contains(where: { $0.id == place.id })
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoritePlaces) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey),
           let decoded = try? JSONDecoder().decode([Place].self, from: savedData) {
            favoritePlaces = decoded
        }
    }
}
