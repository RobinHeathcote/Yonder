//
//  YonderApp.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import SwiftData
import SwiftUI

@main
struct YonderApp: App {
    init() {
        _ = PhoneConnectivityManager.shared
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Route.self)
    }
}
