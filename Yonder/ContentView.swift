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
                    VStack(alignment: .leading) {
                        Text(route.name)
                            .font(.headline)
                        
                        Text(route.type)
                    }
                }
            }
            .navigationTitle("Yonder")
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
}

#Preview {
    ContentView()
}
