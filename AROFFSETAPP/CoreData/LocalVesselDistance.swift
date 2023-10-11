//
//  VesselDistance.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import Foundation


struct LocalVesselDistance: Identifiable {
    
    var id: UUID
    var x1: Float
    var x2: Float
    var y1: Float
    var y2: Float
    var z1: Float
    var z2: Float
    var distance: Float
    var date: Date
    
    init(id: UUID = UUID(), x1: Float, x2: Float, y1: Float, y2: Float, z1: Float, z2: Float, distance: Float, date: Date = Date()) {
        self.id = id
        self.x1 = x1
        self.x2 = x2
        self.y1 = y1
        self.y2 = y2
        self.z1 = z1
        self.z2 = z2
        self.distance = distance
        self.date = date
    }
}
