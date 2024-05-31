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
    @State private var path = [Route]()
    
    var body: some View {
        NavigationStack(path: $path) {
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
                Button("Add Route", systemImage: "plus", action: addRoute)
            }
        }
    }
    
    func addRoute() {
        let route = Route()
        modelContext.insert(route)
        path = [route]
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
