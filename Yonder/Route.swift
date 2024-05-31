//
//  Route.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import Foundation
import SwiftData

@Model
class Route {
    var name: String
    var details: String
    var type: String
    var routeData: [String]
    
    init(name: String = "", details: String = "", type: String = "", routeData: [String] = []) {
        self.name = name
        self.details = details
        self.type = type
        self.routeData = routeData
    }
}
