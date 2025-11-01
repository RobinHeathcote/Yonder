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

    var body: some View {
        Map(position: $cameraPosition, interactionModes: []) {
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

#Preview {
    RouteMapView()
        .environmentObject(WorkoutManager())
}
