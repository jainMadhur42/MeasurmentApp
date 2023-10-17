//
//  MainView.swift
//  AROFFSETAPP
//
//  Created by Madhur on 16/10/23.
//

import SwiftUI

struct MainView: View {
    
    var vesselInfoLoader: VesselInfoLoader
    var vesselDistanceLoader: VesselDistanceLoader
    @State private var vessels = [LocalVesselInfo]()
    @AppStorage(Constants.activeVessel) private var activeVesselInfo = UUID().uuidString
    
    var body: some View {
        
        ContentView(vessels: $vessels, markAsSelected: { uuid in
            activeVesselInfo = uuid
            self.vessels = mapSelection(vessels: self.vessels)
        }, insert: insert, injectedView: {
            ARView(activeVesselId: UUID(uuidString: activeVesselInfo)!)
        })
        .onAppear() {
            refresh()
        }
    }
    
    private func refresh() {
        vesselInfoLoader.retrieve { result in
            switch result {
            case .success(let vessels):
                self.vessels = mapSelection(vessels: vessels)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func mapSelection(vessels: [LocalVesselInfo]) -> [LocalVesselInfo] {
        
        return vessels.map {
            LocalVesselInfo(id: $0.id
                            , contactEmail: $0.contactEmail
                            , contactPersonName: $0.contactPersonName
                            , vesselName: $0.vesselName
                            , organisation: $0.organisation
                            , isSelected: activeVesselInfo == $0.id.uuidString)
        }
    }
    
    private func insert(localVesselInfo: LocalVesselInfo) {
        vesselInfoLoader.insert(vesselInfo: localVesselInfo, completion: { result in
            switch result {
            case .success(let uuid):
                activeVesselInfo = uuid.uuidString
            case .failure(let error):
                print("error Occurred \(error)")
            }
            refresh()
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vesselInfoLoader: LocalVesselLoader(), vesselDistanceLoader: LocalVesselLoader())
    }
}
