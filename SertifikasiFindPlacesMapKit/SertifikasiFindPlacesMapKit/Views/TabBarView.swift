import SwiftUI

struct TabBarView: View {
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some View {
        TabView {
            MyLocationView()
                .tabItem {
                    Label("My Location", systemImage: "location.circle.fill")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .environmentObject(favoritesManager)
    }
}

