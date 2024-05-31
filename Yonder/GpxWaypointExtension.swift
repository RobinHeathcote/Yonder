//
//  GPXWaypointExtension.swift
//  Yonder
//
//  Created by Robin Heathcote on 31/05/2024.
//

import Foundation
import MapKit
import CoreGPX

extension GPXWaypoint : MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        set {
            self.latitude = newValue.latitude
            self.longitude = newValue.longitude
        }
        get {
            return CLLocationCoordinate2D(latitude: self.latitude!, longitude: CLLocationDegrees(self.longitude!))
        }
    }
}
