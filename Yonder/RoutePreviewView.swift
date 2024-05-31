//
//  RoutePreviewView.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import SwiftUI
import MapKit
import SwiftData

struct RoutePreviewView: View {
    @Bindable var route: Route
    var body: some View {
        Map {
            MapPolyline(coordinates: drawPolyline())
                .stroke(.blue, lineWidth: 2.0)
        }
    }
    
    func drawPolyline() -> [CLLocationCoordinate2D] {
        var coords: [CLLocationCoordinate2D] = []
        for point in route.pathData {
            coords.append(point.coordinate)
        }
        
        return coords
    }
}

#Preview {
    do {
        let config = ModelConfiguration( isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Route.self, configurations: config)
        let example = Route(name: "Example Route", type: "Run", pathData: [])
        return EditRouteView(route: example)
            .modelContainer(container)
        
    } catch {
        fatalError("Failed to create model container")
    }
}
