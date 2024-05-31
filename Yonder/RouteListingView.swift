//
//  RouteListingView.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import SwiftUI
import SwiftData

struct RouteListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Route.name) var routes: [Route]

    var body: some View {
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
    }
    
    init(sort: SortDescriptor<Route>, searchString: String) {
        _routes = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        },
        sort: [sort])
    }
    
    func deleteRoutes(_ indexSet: IndexSet) {
        for index in indexSet {
            let route = routes[index]
            
            modelContext.delete(route)
        }
    }
}

#Preview {
    RouteListingView(sort: SortDescriptor(\Route.name), searchString: "")
}
