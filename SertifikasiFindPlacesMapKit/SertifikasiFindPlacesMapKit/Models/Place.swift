//
//  Places.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 22/02/25.
//
import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String
    let phoneNumber: String?
    let website: URL?
    let category: String?
    
    init(mapItem: MKMapItem) {
        self.name = mapItem.name ?? "Unknown"
        self.coordinate = mapItem.placemark.coordinate
        self.address = "\(mapItem.placemark.thoroughfare ?? ""), \(mapItem.placemark.locality ?? ""), \(mapItem.placemark.country ?? "")"
        self.phoneNumber = mapItem.phoneNumber
        self.website = mapItem.url
        self.category = mapItem.pointOfInterestCategory?.rawValue
    }
}

