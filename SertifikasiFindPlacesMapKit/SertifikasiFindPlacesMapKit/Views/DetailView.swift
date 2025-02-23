import SwiftUI
import MapKit

struct DetailView: View {
    let place: Place
    @State private var region: MKCoordinateRegion

    init(place: Place) {
        self.place = place
        _region = State(initialValue: MKCoordinateRegion(
            center: place.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }
    
    var body: some View {
        Form {
            Section(header: Text("Place Information")) {
                Text(place.name)
                    .font(.title2)
                    .bold()
                
                Text("📍 \(place.address)")
                
                if let phoneNumber = place.phoneNumber {
                    HStack {
                        Image(systemName: "phone.fill")
                        Button("Call \(phoneNumber)") {
                            if let url = URL(string: "tel://\(phoneNumber)") {
                                UIApplication.shared.open(url)
                            }
                        }
                        .foregroundColor(.blue)
                    }
                }
                
                if let website = place.website {
                    Link(destination: website) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Visit Website")
                        }
                        .foregroundColor(.blue)
                    }
                }
                
                if let category = place.category {
                    HStack {
                        Image(systemName: "tag.fill")
                        Text(category)
                    }
                }
            }
            
            Section(header: Text("Location")) {
                Map(coordinateRegion: $region, annotationItems: [place]) { place in
                    MapAnnotation(coordinate: place.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
                .frame(height: 300)
                .cornerRadius(12)
            }
        }
        .navigationTitle("Details")
    }
}
