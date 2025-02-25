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
    private var lastLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }

        if let lastLocation = lastLocation, location.distance(from: lastLocation) < 500 {
            return 
        }

        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }

        self.lastLocation = location
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
