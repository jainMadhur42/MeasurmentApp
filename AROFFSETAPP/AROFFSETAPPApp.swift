//
//  AROFFSETAPPApp.swift
//  AROFFSETAPP
//
//  Created by Darshan Gummadi on 9/11/23.
//

import SwiftUI

@main
struct AROFFSETAPPApp: App {
    
    var body: some Scene {
        WindowGroup {
            SplashView(vesselDistanceLoader: CoreDataVesselLoader(), vesselInfoLoader: CoreDataVesselLoader())
        }
    }
}
