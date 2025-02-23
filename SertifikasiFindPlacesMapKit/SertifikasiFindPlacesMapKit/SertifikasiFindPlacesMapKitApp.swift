//
//  SertifikasiFindPlacesMapKitApp.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 22/02/25.
//

import SwiftUI

@main
struct SertifikasiFindPlacesMapKitApp: App {
    @StateObject private var favoritesManager = FavoritesManager()

    var body: some Scene {
        WindowGroup {
            TabBarView()
        }
    }
}
