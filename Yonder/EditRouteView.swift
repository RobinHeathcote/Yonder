//
//  EditRouteView.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import SwiftUI
import SwiftData

struct EditRouteView: View {
    @Bindable var route: Route
    var body: some View {
        Form {
            TextField("Route", text: $route.name)
            Section("Type") {
                Picker("Type", selection: $route.type) {
                    Text("Run").tag("Run")
                    Text("Hike").tag("Hike")
                }
            }
            TextField("Details", text: $route.details)
        }
        .navigationTitle("Edit Route")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration( isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Route.self, configurations: config)
        let example = Route(name: "Example Route", type: "Run")
        return EditRouteView(route: example)
            .modelContainer(container)
        
    } catch {
        fatalError("Failed to create model container")
    }
    
}
