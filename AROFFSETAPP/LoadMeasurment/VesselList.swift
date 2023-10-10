//
//  VesselList.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct VesselList: View {
    
    @State private var vessels: [String] = ["Vessel 1","Vessel 2","Vessel 3", "Vessel 4", "Vessel 5"]
     
    var body: some View {
        
        List(vessels, id: \.self) { vessel in
            NavigationLink(vessel) {
                MeasurmentList()
            }
        }
        
    }
}

struct VesselList_Previews: PreviewProvider {
    static var previews: some View {
        VesselList()
    }
}
