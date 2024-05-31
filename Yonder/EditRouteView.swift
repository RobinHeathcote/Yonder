//
//  EditRouteView.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import SwiftUI
import SwiftData
import UniformTypeIdentifiers
import CoreGPX

struct EditRouteView: View {
    @Bindable var route: Route
    @State private var filePickerText = ""
    @State private var filePickerError: Error?
    @State private var isImporting = false
    
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
            
            Section("Add a Route") {
                Button {
                  isImporting = true
                } label: {
                    Label("Import file",
                          systemImage: "square.and.arrow.down")
                }
            }
        }
        .fileImporter(isPresented: $isImporting,
                      allowedContentTypes: [UTType(filenameExtension: "gpx")!]) {
            let result = $0.flatMap { url in
                read(from: url)
            }
            switch result {
            case .success(let text):
                self.filePickerText += text
            case .failure(let error):
                self.filePickerError = error
            }
        }
        .navigationTitle("Edit Route")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func read(from url: URL) -> Result<String, Error> {
        let gpx = GPXParser(withURL: url)?.parsedData()
        route.pathData = gpx?.routes ?? []
        return Result { try String(contentsOf: url) }
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
