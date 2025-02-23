//
//  LocationSearchViewModel.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 22/02/25.
//
import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var searchQuery = ""
    @Published var places: [Place] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    private var locationManager = CLLocationManager()
    private var cache: [String: [Place]] = [:] // Cache storage
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // Request location permission
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                self.searchNearbyPlaces(location: location)
            }
        }
    }

    func searchPlaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                DispatchQueue.main.async {
                    self.places = response.mapItems.map { Place(mapItem: $0) }
                }
            }
        }
    }

    func searchNearbyPlaces(location: CLLocation) {
        let request = MKLocalSearch.Request()
        request.region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                DispatchQueue.main.async {
                    self.places = response.mapItems.map { Place(mapItem: $0) }
                }
            }
        }
    }
}
