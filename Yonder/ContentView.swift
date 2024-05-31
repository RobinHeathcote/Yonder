//
//  ContentView.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var routes: [Route]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(routes) { route in
                    NavigationLink(value: route) {
                        VStack(alignment: .leading) {
                            Text(route.name)
                                .font(.headline)
                            
                            Text(route.type)
                        }
                    }
                }
                .onDelete(perform: deleteRoutes)
            }
            .navigationTitle("Yonder")
            .navigationDestination(for: Route.self, destination: EditRouteView.init)
            .toolbar {
                Button("Add Routes", action: addRoutes)
            }
        }
    }
    
    func addRoutes() {
        let hopeValleyRound = Route(name: "Hope Valley Round", type: "Run")
        let edaleSkyline = Route(name: "Edale Skyline", type: "Run")
        
        modelContext.insert(hopeValleyRound)
        modelContext.insert(edaleSkyline)
    }
    
    func deleteRoutes(_ indexSet: IndexSet) {
        for index in indexSet {
            let route = routes[index]
            
            modelContext.delete(route)
        }
    }
}

#Preview {
    ContentView()
}
