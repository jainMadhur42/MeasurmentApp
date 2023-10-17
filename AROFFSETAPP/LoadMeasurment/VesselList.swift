//
//  VesselList.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct VesselList: View {
    
    @Binding var vessels: [LocalVesselInfo]
    var markAsSelected: (String) -> Void
    
    var body: some View {
        
        List(vessels, id: \.id) { vessel in
            HStack {
                Image(systemName: "checkmark.circle")
                    .opacity(vessel.isSelected ? 1.0 : 0.0)
                    .foregroundColor(ThemeColor.tint.color)
                
                NavigationLink {
                    MeasurmentList(vesselLoader: CoreDataVesselLoader(), vesselId: vessel.id)
                } label: {
                    Text(vessel.vesselName)
                }
            }
            .swipeActions {
                Button("Mark as active") {
                    markAsSelected(vessel.id.uuidString)
                }
                .tint(ThemeColor.tint.color)
            }
        }
        
    }
}

struct VesselList_Previews: PreviewProvider {
    static var previews: some View {
        VesselList(vessels: .constant(LocalVesselLoader.vessels), markAsSelected: {
            print($0)
        })
    }
}
