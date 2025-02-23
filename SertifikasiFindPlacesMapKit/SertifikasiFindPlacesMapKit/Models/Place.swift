//
//  Places.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 22/02/25.
//
import Foundation
import MapKit

struct Place: Identifiable, Codable {
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double
    let address: String
    let phoneNumber: String?
    let website: URL?
    let category: String?

    init(mapItem: MKMapItem) {
        self.id = UUID()
        self.name = mapItem.name ?? "Unknown"
        self.latitude = mapItem.placemark.coordinate.latitude
        self.longitude = mapItem.placemark.coordinate.longitude
        self.address = "\(mapItem.placemark.thoroughfare ?? ""), \(mapItem.placemark.locality ?? ""), \(mapItem.placemark.country ?? "")"
        self.phoneNumber = mapItem.phoneNumber
        self.website = mapItem.url
        self.category = mapItem.pointOfInterestCategory?.rawValue
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
