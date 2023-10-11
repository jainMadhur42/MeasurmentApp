//
//  VesselList.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct VesselList: View {
    
    var vesselInfoLoader: VesselInfoLoader
    @State private var vessels = [LocalVesselInfo]()
    
    var body: some View {
        
        List(vessels, id: \.id) { vessel in
            NavigationLink(vessel.vesselName) {
                MeasurmentList(vesselLoader: CoreDataVesselLoader())
            }
        }
        .onAppear() {
            vesselInfoLoader.retrieve { result in
                switch result {
                case .success(let vessels):
                    self.vessels = vessels
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct VesselList_Previews: PreviewProvider {
    static var previews: some View {
        VesselList(vesselInfoLoader: LocalVesselLoader())
    }
}
