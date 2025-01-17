//
//  YonderApp.swift
//  Yonder Watch App
//
//  Created by Robin Heathcote on 31/05/2024.
//

import SwiftUI

@main
struct Yonder_Watch_AppApp: App {
    @StateObject var workoutManager = WorkoutManager()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                StartView()
            }
            .sheet(isPresented: $workoutManager.showingSummaryView) {
                SummaryView()
            }
            .environmentObject(workoutManager)
        }
    }
}
