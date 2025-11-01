import SwiftUI
import MapKit

struct RouteMapView: View {
    @StateObject private var wc = WatchConnectivityManager.shared
    @EnvironmentObject var workoutManager: WorkoutManager
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.5072, longitude: -0.1276),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    )
    @State private var position: MapCameraPosition = .userLocation(followsHeading: false, fallback: .automatic)
    private var lm = LocationManager()

    var body: some View {
        Map(position: $cameraPosition, interactionModes: [.zoom]) {
            UserAnnotation.init()
            if workoutManager.routePoints.count > 1 {
                MapPolyline(coordinates: workoutManager.routePoints)
                    .stroke(.blue, lineWidth: 3)
            }
        }
        .onChange(of: workoutManager.routePoints.count) { oldValue, newValue in
            if let first = workoutManager.routePoints.first {
                let region = MKCoordinateRegion(
                    center: first,
                    span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                )
                cameraPosition = .region(region)
            }
        }
        .accessibilityLabel("Route Map")
        .onReceive(wc.$incomingRoute) { newRoute in
            guard !newRoute.isEmpty else { return }
            workoutManager.routePoints = newRoute
        }
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    private var lm = CLLocationManager()

    override init() {
        super.init()

        lm.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorizedAlways:
                print("always")
            case .authorizedWhenInUse:
                print("in use")
            @unknown default:
                print("other")
        }
    }
}

#Preview {
    RouteMapView()
        .environmentObject(WorkoutManager())
}
