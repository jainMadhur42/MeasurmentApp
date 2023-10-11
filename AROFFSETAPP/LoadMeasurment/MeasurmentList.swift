//
//  MeasurmentList.swift
//  AROFFSETAPP
//
//  Created by Madhur on 10/10/23.
//

import SwiftUI

struct MeasurmentList: View {

    var vesselLoader: VesselDistanceLoader
    @State var vesselDistances: [LocalVesselDistance] = []
    
    var body: some View {
        List(vesselDistances) { vesselDistance in
            MeasurmentListItem(vesselDistance: vesselDistance)
        }
        .onAppear() {
            vesselLoader.retrieve { result in
                switch result {
                case .success(let distances):
                    self.vesselDistances = distances
                case .failure(let error):
                    print("Error")
                }
            }
        }
    }
}

struct MeasurmentList_Previews: PreviewProvider {
    static var previews: some View {
        MeasurmentList(vesselLoader: LocalVesselLoader())
    }
}
