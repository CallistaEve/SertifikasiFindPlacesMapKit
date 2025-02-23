//
//  ContentView.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 22/02/25.
//

import SwiftUI
import MapKit

struct MyLocationView: View {
    @ObservedObject private var viewModel = LocationSearchViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                    .edgesIgnoringSafeArea(.top)
            }
            .navigationTitle("My Location")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

