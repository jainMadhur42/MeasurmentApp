//
//  LocalVesselInfo.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import Foundation

struct LocalVesselInfo: Hashable, Identifiable {
    
    var id: UUID
    var contactEmail: String
    var contactPersonName: String
    var vesselName: String
    var organisation: String
}
