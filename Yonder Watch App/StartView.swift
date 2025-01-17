//
//  StartView.swift
//  Yonder
//
//  Created by Robin Heathcote on 17/01/2025.
//

import SwiftUI
import HealthKit
struct StartView: View {
    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]
    var body: some View {
        List(workoutTypes) { workoutType in
            NavigationLink(
                workoutType.name,
                destination: Text(workoutType.name)
            ).padding(
                EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5)
            )
        }
        .listStyle(.carousel)
        .navigationBarTitle("Workouts")
    }
}

#Preview {
    StartView()
}
extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }

    var name: String {
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        default:
            return ""
        }
    }
}

