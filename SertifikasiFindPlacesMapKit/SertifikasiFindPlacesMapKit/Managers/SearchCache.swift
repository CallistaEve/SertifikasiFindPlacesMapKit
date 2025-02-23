//
//  SearchCaching.swift
//  SertifikasiFindPlacesMapKit
//
//  Created by Evelyn Callista Yaurentius on 23/02/25.
//

import Foundation
import MapKit

class SearchCache {
    static let shared = SearchCache()
    private let cache = NSCache<NSString, NSArray>()

    func saveResults(for query: String, places: [Place]) {
        cache.setObject(places as NSArray, forKey: query as NSString)
    }

    func getResults(for query: String) -> [Place]? {
        return cache.object(forKey: query as NSString) as? [Place]
    }
}
