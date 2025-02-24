import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var searchQuery = ""
    @Published var places: [Place] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    private var locationManager = CLLocationManager()
    private var hasSetRegion = false 
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        DispatchQueue.main.async {
            if !self.hasSetRegion { // Only set the region once
                self.region = MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )
                self.hasSetRegion = true
            }
        }
    }

    func searchPlaces() {
        if let cachedResults = SearchCache.shared.getResults(for: searchQuery) {
            self.places = cachedResults
            return
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        request.region = region
        let search = MKLocalSearch(request: request)

        search.start { response, _ in
            if let response = response {
                DispatchQueue.main.async {
                    let results = response.mapItems.map { Place(mapItem: $0) }
                    self.places = results
                    SearchCache.shared.saveResults(for: self.searchQuery, places: results)
                }
            }
        }
    }
}
