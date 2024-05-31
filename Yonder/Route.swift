//
//  Route.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import Foundation
import SwiftData
import CoreGPX

@Model
class Route {
    var name: String
    var details: String
    var type: String
    var routeData: [String]
    var pathData: [GPXRoute]
    
    init(name: String = "", details: String = "", type: String = "", routeData: [String] = [], pathData: [GPXRoute] = []) {
        self.name = name
        self.details = details
        self.type = type
        self.routeData = routeData
        self.pathData = pathData
    }
}
