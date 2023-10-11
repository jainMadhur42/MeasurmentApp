//
//  ManagedVesselInfo.swift
//  AROFFSETAPP
//
//  Created by Madhur on 11/10/23.
//

import CoreData

@objc(ManagedVesselInfo)
class ManagedVesselInfo: NSManagedObject {
    
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var contact: String
}
