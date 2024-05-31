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
    @State private var path = [Route]()
    @State private var sortOrder = SortDescriptor(\Route.name)
    
    var body: some View {
        NavigationStack(path: $path) {
            RouteListingView(sort: sortOrder)
            .navigationTitle("Yonder")
            .navigationDestination(for: Route.self, destination: EditRouteView.init)
            .toolbar {
                Button("Add Route", systemImage: "plus", action: addRoute)
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Route.name))
                        Text("Type")
                            .tag(SortDescriptor(\Route.type))
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
    

    
    func addRoute() {
        let route = Route()
        modelContext.insert(route)
        path = [route]
    }
    

}

#Preview {
    ContentView()
}
